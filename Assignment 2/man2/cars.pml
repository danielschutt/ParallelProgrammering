
#define N 4


int up = 0;
int down = 0;

int upSpin = 0;
int downSpin = 0;

bool upSem = 1;
bool downSem = 1;

#define P(Sem) Sem == 1 -> Sem = 0;
#define V(Sem) Sem = 1;

active [N] proctype Car()
{
	do ::
		if 
		:: (_pid < N/2) ->
			P(downSem);
			if 
			:: down == 0 ->
				P(upSem);
			fi;
			int temp;			
			temp = down;
			down = temp + 1;
			
			V(downSem)
			
			
		:: else ->
			P(upSem);
			if 
			:: up == 0 ->
				P(downSem);
			fi;
			int temp2;			
			temp2 = up;
			up = temp2 + 1;
			
			V(upSem)
		fi;
		

		if 
		:: (_pid < N/2) ->
			downSpin++;
		::else -> 
			upSpin++;
		fi;

		
		assert(upSpin <=N/2 && downSpin == 0 || downSpin <= N/2 && upSpin == 0);
		
		if 
		:: (_pid < N/2) ->
			downSpin--;
		::else -> 
			upSpin--;
		fi;


// ********* leave *******
		if 
		:: (_pid < N/2) -> 
			int temp3;
			temp3 = down;
			temp3--;
			
			down = temp3;
			if :: down == 0 ->
				V(upSem);
			fi;
		:: else -> 
			int temp4;
			temp4 = up;
			temp4--;
			up = temp4;
			if :: up == 0 ->
				V(downSem);
			fi;
		fi;
	od;
	
}


