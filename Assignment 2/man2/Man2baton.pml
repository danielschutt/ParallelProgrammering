

#define N 4

int up = 0;
int down = 0;

int delayedUp = 0;
int delayedDown = 0;

bool enterSem = 1;
bool upSem = 0;
bool downSem = 0;

#define P(Sem) (Sem == 1) -> Sem = 0;
#define V(Sem) Sem = 1;





active [N] proctype Car()
{
	do 
	::
		skip;
	
enter:
// Down cars
		if
		:: (_pid < N/2) ->
			P(enterSem);
			if 
			:: (up > 0) ->
				delayedDown++;
				V(enterSem);
				P(downSem);
			:: else -> skip;
			fi;
			down++;

			// SIGNAL:
			if
			:: (delayedDown > 0) ->
				delayedDown--;
				V(downSem);
			:: else ->
				V(enterSem);
			fi;
				
		
// Up Cars				
		:: else -> 
			P(enterSem);
			if
			:: (down > 0) ->
				delayedUp++;
				V(enterSem);
				P(upSem);
			:: else -> skip;
			fi;
			up++;

			// SIGNAL
			if
			:: (delayedUp > 0) ->
				delayedUp--;
				V(upSem);
			:: else ->
				V(enterSem);
			fi;
		fi;

ally:
		assert((down <= N/2 && up == 0) || (up <= N/2 && down == 0));

leave:

// Down cars 
		if
		:: (_pid < N/2) ->
			P(enterSem);
			down--;			

			// SIGNAL
			if 
			:: (down == 0 && delayedUp > 0) -> 
				delayedUp--;
				V(upSem);
			:: else -> 
				V(enterSem);
			fi;
				
// Up cars
		:: else -> 
			P(enterSem);
			up--;	

			// SIGNAL
			if 
			:: (up == 0 && delayedDown > 0) -> 
				delayedDown--;
				V(downSem); 
			:: else -> 
				V(enterSem);
			fi;
		fi;
	od
}
