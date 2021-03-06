/*
 * @LANG: indep
 */
bool neg;
int val;

val = 0;
neg = false;
%%{
	machine AtoI;

	action begin {
		neg = false;
		val = 0;
	}

	action see_neg {
		neg = true;
	}

	action add_digit { 
		val = val * 10 + <int>(fc - 48);
	}

	action finish {
		if ( neg != 0 ) {
			val = -1 * val;
		}
	}
	action print {
		print_int val;
		print_str "\n";
	}

	atoi = (
		('-'@see_neg | '+')? (digit @add_digit)+
	) >begin %finish;

	main := atoi '\n' @print;
}%%

#ifdef _____INPUT_____
"1\n"
"12\n"
"222222\n"
"+2123\n"
"213 3213\n"
"-12321\n"
"--123\n"
"-99\n"
" -3000\n"
#endif

#ifdef _____OUTPUT_____
1
ACCEPT
12
ACCEPT
222222
ACCEPT
2123
ACCEPT
FAIL
-12321
ACCEPT
FAIL
-99
ACCEPT
FAIL
#endif
