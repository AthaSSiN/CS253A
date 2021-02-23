#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    ofstream outf("S", ios::out | ios::trunc );

    int n, t, k, len;
    cin >> n >> t >> k >> len;

    int testCases[n][t];

    for(int i = 0; i < n; ++i)
        for(int j = 0; j < t; ++j)
            cin >> testCases[i][j];

    int oneHot[n][len];

    for(int i = 0; i < n; ++i)
        for(int j = 0; j < len; ++j)
            cin >> oneHot[i][j];

    int original = 0;
    for(int j = 0; j < len; ++j) // All non zero values in the oneHot vector of the last test case means that the branch was taken by atleast pne test case earlier
        if(oneHot[n-1][j] > 0)
            original++;

    cout<< "Original branch coverage: "<<original<<"/"<<len<<"\n";
    
    //The following step is require because currently, each position in the vector denotes the number of times the branch was taken till that test case was run.
    //Hence, subtracting the values of a branch in a test case and in the previous test case results in telling whether that branch was taken in that particular test case or not.
    for(int i = n-1; i > 0; --i)
        for(int j = 0; j < len; ++j)
            oneHot[i][j] -= oneHot[i-1][j];
    
    int total = 0; // counts the number of branches in taken.
    int _k = 0;

    bool takenBranches[len] = {0}; // vector to store all taken branches

    for(; _k < k; ++_k) // iterate till K steps
    {
        int maxx = -1;
        int maxSum = -1;
        for(int i = 0; i < n; ++i)
        {
            int temp = 0;
            // add the branches taken by the test case AND NOT already taken by previous test cases.
            for(int j = 0; j < len; ++j)
                temp += (oneHot[i][j] && !takenBranches[j]);

            // If the sum is greater than the maximum till now, then make it the new max.
            if(temp > maxSum)
            {
                maxx = i;
                maxSum = temp;
            }
        }

        total += maxSum; 

        // update taken branches with branches taken by the maximum sum vector OR those already taken by earlier testcases.
        for(int j = 0; j < len; ++j)
            takenBranches[j] = (oneHot[maxx][j] || takenBranches[j]); 
        
        // print test case to file
        for(int i = 0; i < t; ++i)
            outf << testCases[maxx][i] << " ";
        outf <<'\n';

        // break the loop if total covered branches by the selected test cases becomes equal to the total branch covered by the entire test set.
        if(total == original)
        {
            _k++;
            break;
        }
    }

    cout << "Final branch coverage: "<<total<<"/"<<len;
    cout << "\nTotal "<<_k<<" test cases written to file S\n";

}
