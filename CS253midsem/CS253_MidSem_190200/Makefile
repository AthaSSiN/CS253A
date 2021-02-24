CC=gcc

%.o : %.S
	@echo "Compiling $* into LSB relocatable"
	${CC} -c $< -o $@

all : all_8oc_vec_ptr_87.o final_test_gen.o hl98_httpreq_func_89.o
	@echo "Linking all the relocatables, to get the binary secret"
	${CC} all_8oc_vec_ptr_87.o final_test_gen.o hl98_httpreq_func_89.o -o secret

clean :
	rm -rf *.o secret