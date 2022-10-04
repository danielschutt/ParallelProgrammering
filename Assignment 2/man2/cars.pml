
#define N 8


int up = 0;
int down = 0;

bool upSem = 1;
bool downSem = 1;
active [N] proctype Car()
{
	do ::
		if 
		:: (_pid < N/2) ->
			downSem == 1 ->
			downSem = 0;
			if 
			:: down == 0 ->
				upSem == 1 ->
				upSem = 0;
			fi;
			int temp;			
			temp = down;
			down = temp + 1;
			downSem = 1;
			
			
		:: else ->
			upSem == 1 ->
			upSem = 0;
			if 
			:: up == 0 ->
				downSem == 1 ->
				downSem = 0;
			fi;
			int temp2;			
			temp2 = up;
			up = temp2 + 1;
			upSem = 1;
		fi;


		
		assert(up <=N/2 && down == 0 || down <= N/2 && up == 0);
		



// ********* leave *******
		if 
		:: (_pid < N/2) -> 
			int temp3;
			temp3 = down;
			temp3--;
			down = temp3;
			if :: down == 0 ->
				upSem = 1;
			fi;
		:: else -> 
		int temp4;
			temp4 = up;
			temp4--;
			up = temp4;
			if :: up == 0 ->
				downSem = 1;
			fi;
		fi;
	od;
	
}


