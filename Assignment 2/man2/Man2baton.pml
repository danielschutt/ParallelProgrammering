

#define N 8

int up = 0;
int down = 0;

int delayedUp = 0;
int delayedDown = 0;

bool enterSem = 1;
bool upSem = 0;
bool downSem = 0;

#define P(Sem) atomic{(Sem == 1) -> Sem = 0;}
#define V(Sem) Sem = 1;


active [N] proctype Car()
{
	do 
	::
		skip;
	
enter:
// Down cars

		P(enterSem);
		if
		:: (_pid < N/2) ->
			if 
			:: (up > 0) ->
				delayedDown++;
				V(enterSem);
				P(downSem);
				delayedDown--;
			:: else -> skip;
			fi;
			down++;

			// SIGNAL:
			if
			:: (delayedDown > 0) ->
				V(downSem);
			:: else ->
				V(enterSem);
			fi;
				
		
// Up Cars				
		:: else -> 
			//P(enterSem); REMOVE
			if
			:: (down > 0) ->
				delayedUp++;
				V(enterSem);
				P(upSem);
				delayedUp--;
			:: else -> skip;
			fi;
			up++;

			// SIGNAL
			if
			:: (delayedUp > 0) ->
				V(upSem);
			:: else ->
				V(enterSem);
			fi;
		fi;

ally:
		assert((down <= N/2 && up == 0) || (up <= N/2 && down == 0));
		assert((downSem + upSem + enterSem) <= 1);
leave:

// Down cars 

		P(enterSem);
		if
		:: (_pid < N/2) ->
			down--;			

			// SIGNAL
			if 
			:: (down == 0 && delayedUp > 0) -> 
				V(upSem);
			:: else -> 
				V(enterSem);
			fi;
				
// Up cars
		:: else -> 
			up--;	

			// SIGNAL
			if 
			:: (up == 0 && delayedDown > 0) -> 
				V(downSem); 
			:: else -> 
				V(enterSem);
			fi;
		fi;
	od
}
