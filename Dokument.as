package  {
	
	import flash.display.MovieClip;
	import flash.text.*
	import flash.events.MouseEvent;
	
	public class Dokument extends MovieClip {
		private var smaFrikanter:Array= new Array();
		private var smaFrikanterX:Array= new Array();
		private var smaFrikanterY:Array= new Array();
		private var ferdigMedSok:Boolean=false;
		private var eksempelTall:Array=new Array();
		
		
		private var bestemteTall:Array=new Array();
		private var feltIgjen:uint;
		private var gamleFeltIgjen:uint;
		
		private var fieldsx:Array=new Array();
		private var fieldsy:Array=new Array();
		
		private var alternativeTallX:Array=new Array();
		private var alternativeTallY:Array=new Array();
		
		private const textbredde:uint=50;
		private const texthoyde:uint=50;
		private const textmellomromX:uint=60;
		private const textmellomromY:uint=60;
		public function Dokument() {
			//test sudoku tall:
			
			bestemteTall[0]=[0,7,5,2,0,9,3,6,0];
			bestemteTall[1]=[9,0,0,0,3,0,0,0,4];
			bestemteTall[2]=[3,0,1,0,6,0,2,0,7];
			bestemteTall[3]=[1,0,2,0,9,0,4,0,3];
			bestemteTall[4]=[0,0,0,0,0,0,0,0,0];
			bestemteTall[5]=[5,0,9,0,7,0,8,0,2];
			bestemteTall[6]=[6,0,3,0,5,0,1,0,8];
			bestemteTall[7]=[4,0,0,0,2,0,0,0,5];
			bestemteTall[8]=[0,5,7,3,0,1,9,4,0];
			
			
			eksempelTall[0]=[0,7,5,2,0,9,3,6,0];
			eksempelTall[1]=[9,0,0,0,3,0,0,0,4];
			eksempelTall[2]=[3,0,1,0,6,0,2,0,7];
			eksempelTall[3]=[1,0,2,0,9,0,4,0,3];
			eksempelTall[4]=[0,0,0,0,0,0,0,0,0];
			eksempelTall[5]=[5,0,9,0,7,0,8,0,2];
			eksempelTall[6]=[6,0,3,0,5,0,1,0,8];
			eksempelTall[7]=[4,0,0,0,2,0,0,0,5];
			eksempelTall[8]=[0,5,7,3,0,1,9,4,0];
			
			smaFrikanter[0]=[0,1,2];
			smaFrikanter[1]=[3,4,5];
			smaFrikanter[2]=[6,7,8];
		
			// constructor code
			for(var px:uint=0;px<9;px++){
				for(var py:uint=0;py<9;py++){
					
					alternativeTallY.push([1,2,3,4,5,6,7,8,9]);
					var tekst=new Tekst();
					tekst.x=50+textmellomromX*px;
					tekst.y=50+textmellomromY*py;
					fieldsy.push(tekst);
					addChild(tekst);
				}
				alternativeTallX.push(alternativeTallY);
				alternativeTallY=[];
				
				fieldsx.push(fieldsy);
				fieldsy=[];
			}
			//trace(alternativeTallX[6][0]);
			los_btn.addEventListener(MouseEvent.CLICK, startSok);
			eksempel.addEventListener(MouseEvent.CLICK, startEksempel);
		}
		
		
		function startEksempel(evt:MouseEvent){
			for(var ix:uint=0;ix<9;ix++){
				for(var iy:uint=0;iy<9;iy++){
					fieldsx[ix][iy].tekst_txt.text=eksempelTall[ix][iy];
				}
			}
		}
		
		
		
		function startSok(evt:MouseEvent){
			for(var nx:uint=0;nx<9;nx++){
				for(var ny:uint=0;ny<9;ny++){
					bestemteTall[x][y]=int(fieldsx[x][y].tekst_txt.text);
					trace(fieldsx[x][y].tekst_txt.text);
				
					if(bestemteTall[nx][ny]!=0){
						alternativeTallX[nx][ny]=[];
						
					}
				}
			}
			//start søking
			while(ferdigMedSok==false){
				feltIgjen=0;
				
				for(var x:uint=0;x<9;x++){
					for(var y:uint=0;y<9;y++){ 
						
						for(var bt:uint=0;bt<9;bt++){
							
							//trace(bestemteTall[y][bt]);
							for(var alternative:uint=0;alternative<alternativeTallX[x][y].length;alternative++){
								
								if(alternativeTallX[x][y][alternative]==bestemteTall[x][bt]){
									//trace(alternativeTallX[x][y][alternative]+"   "+x+y+"    "+bestemteTall[y][bt]);
									alternativeTallX[x][y].splice(alternative,1);
									
								}
								
							}
							for(var alternative2:uint=0;alternative2<alternativeTallX[x][y].length;alternative2++){
								
								if(alternativeTallX[x][y][alternative2]==bestemteTall[bt][y]){
									//trace(alternativeTallX[x][y][alternative]+"   "+x+y+"    "+bestemteTall[y][bt]);
									alternativeTallX[x][y].splice(alternative2,1);
									
								}
								
							}
						}
						if(x<3){
							smaFrikanterX=smaFrikanter[0];
						}
						else if(x<6){
							smaFrikanterX=smaFrikanter[1];
						}
						else {
							smaFrikanterX=smaFrikanter[2];
						}
						if(y<3){
							smaFrikanterY=smaFrikanter[0];
						}
						else if(y<6){
							smaFrikanterY=smaFrikanter[1];
						}
						else {
							smaFrikanterY=smaFrikanter[2];
						}
						for(var ax:uint=0;ax<smaFrikanterX.length;ax++){
							for(var ay:uint=0;ay<smaFrikanterY.length;ay++){
								for(var alternative3:uint=0;alternative3<alternativeTallX[x][y].length;alternative3++){
									if(alternativeTallX[x][y][alternative3]==bestemteTall[smaFrikanterX[ax]][smaFrikanterY[ay]]){
										alternativeTallX[x][y].splice(alternative3,1);
										
									}
								}
							}
						}
						if(alternativeTallX[x][y].length==1){
							bestemteTall[x][y]=alternativeTallX[x][y][0];
							alternativeTallX[x][y]=[];
						}
						//finner ut hvilke av de det bare er en mulighet
						
						//trace("fuck"+String(x)+y+"    "+bestemteTall[y][x]+"        "+alternativeTallX[x][y]);
						
						
						//oppdater tekst

						if(bestemteTall[x][y]!=0){
							fieldsx[x][y].tekst_txt.text=bestemteTall[x][y];
						}
						feltIgjen+=alternativeTallX[4][1].length
						if(feltIgjen==0){
							ferdigMedSok=true;
						}
					}
				}
				if(gamleFeltIgjen==feltIgjen){
					ferdigMedSok=true;
				}
				gamleFeltIgjen=feltIgjen;
			}
		}
	}
}
