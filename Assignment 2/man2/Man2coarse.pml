

#define N 8
int up = 0, down = 0;

active [N] proctype Car()
{
	do 
	::
		skip;
	
enter:
		if
		:: (_pid < N/2) ->
			atomic{(up == 0) -> down = down + 1;}
			
		:: else -> 
			atomic{(down == 0) -> up = up + 1;}
		fi;

ally:
		assert((down <= N/2 && up == 0) || (up <= N/2 && down == 0));

leave:
		if
		:: (_pid < N/2) ->
			down = down - 1;			
			
		:: else -> 
			up = up - 1;		
		fi;
	od
}

