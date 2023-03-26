/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_4(char*, char *);
extern void execute_167(char*, char *);
extern void execute_181(char*, char *);
extern void execute_182(char*, char *);
extern void execute_183(char*, char *);
extern void execute_184(char*, char *);
extern void execute_185(char*, char *);
extern void execute_186(char*, char *);
extern void execute_165(char*, char *);
extern void execute_166(char*, char *);
extern void execute_178(char*, char *);
extern void execute_179(char*, char *);
extern void execute_180(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void execute_13(char*, char *);
extern void execute_14(char*, char *);
extern void execute_15(char*, char *);
extern void execute_16(char*, char *);
extern void execute_17(char*, char *);
extern void execute_18(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_175(char*, char *);
extern void execute_176(char*, char *);
extern void execute_177(char*, char *);
extern void execute_72(char*, char *);
extern void execute_106(char*, char *);
extern void execute_107(char*, char *);
extern void execute_99(char*, char *);
extern void execute_78(char*, char *);
extern void execute_81(char*, char *);
extern void execute_84(char*, char *);
extern void execute_88(char*, char *);
extern void execute_92(char*, char *);
extern void execute_98(char*, char *);
extern void execute_94(char*, char *);
extern void execute_95(char*, char *);
extern void execute_96(char*, char *);
extern void execute_169(char*, char *);
extern void execute_170(char*, char *);
extern void execute_171(char*, char *);
extern void execute_187(char*, char *);
extern void execute_188(char*, char *);
extern void execute_189(char*, char *);
extern void execute_190(char*, char *);
extern void execute_191(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_19(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_25(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_51(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_52(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_73(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_74(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_76(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_104(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[61] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_4, (funcp)execute_167, (funcp)execute_181, (funcp)execute_182, (funcp)execute_183, (funcp)execute_184, (funcp)execute_185, (funcp)execute_186, (funcp)execute_165, (funcp)execute_166, (funcp)execute_178, (funcp)execute_179, (funcp)execute_180, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)execute_13, (funcp)execute_14, (funcp)execute_15, (funcp)execute_16, (funcp)execute_17, (funcp)execute_18, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_175, (funcp)execute_176, (funcp)execute_177, (funcp)execute_72, (funcp)execute_106, (funcp)execute_107, (funcp)execute_99, (funcp)execute_78, (funcp)execute_81, (funcp)execute_84, (funcp)execute_88, (funcp)execute_92, (funcp)execute_98, (funcp)execute_94, (funcp)execute_95, (funcp)execute_96, (funcp)execute_169, (funcp)execute_170, (funcp)execute_171, (funcp)execute_187, (funcp)execute_188, (funcp)execute_189, (funcp)execute_190, (funcp)execute_191, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_19, (funcp)transaction_25, (funcp)transaction_51, (funcp)transaction_52, (funcp)transaction_73, (funcp)transaction_74, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_76, (funcp)transaction_104};
const int NumRelocateId= 61;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_top_behav/xsim.reloc",  (void **)funcTab, 61);
	iki_vhdl_file_variable_register(dp + 229984);
	iki_vhdl_file_variable_register(dp + 230040);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_top_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_top_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 257784, dp + 242112, 0, 7, 0, 7, 8, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 246960, dp + 242168, 0, 7, 0, 7, 8, 1);
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_top_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_top_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_top_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
