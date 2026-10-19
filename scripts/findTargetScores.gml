/*
This script finds the target scores for levels.
*/
for(i=0;i<global.maxLevels;i+=1)
{
  targetTime[i]=1
  targetScore[i]=99999
}

//1-1
targetTime[0]=1650
targetScore[0]=9500
//1-2
targetTime[1]=1650
targetScore[1]=7200
//1-3
targetTime[2]=1500
targetScore[2]=7000
//1-B
targetTime[3]=2040
//2-1
targetTime[4]=1500
targetScore[4]=6500
//2-2
targetTime[5]=1350
targetScore[5]=8900
//2-B
targetTime[6]=1860
//3-1
targetTime[7]=1350
targetScore[7]=8900
//3-2
targetTime[8]=1500
targetScore[8]=9300
//3-3
targetTime[9]=2580
targetScore[9]=8000
//3-B
targetTime[10]=2010
//4-1
targetTime[11]=3450
targetScore[11]=7700
//4-2
targetTime[12]=3450
targetScore[12]=8600
//4-B
targetTime[13]=2100
//5-1
targetScore[14]=20000

/*total level scores from enemies
4500 for Crystals in all non-boss levels

Lvl: Enemy / EnemyCount A/B    / Total
------------------
1-1:  4950 / A: 16 B: 18 T: 34 /  9450
1-2:  3500 / A:  7 B: 17 T: 24 /  8000
1-3:  3400 / A:  8 B: 15 T: 23 /  7900

2-1:  3510 / A: 10 B: 10 T: 20 /  7910
2-2:  4560 / A: 11 B: 18 T: 29 /  9060

3-1:  6200 / A: 12 B: 16 T: 28 /  10700
3-2:  7000 / A: 16 B: 13 T: 29 /  11500
3-3:  5390 / A: 11 B: 18 T: 29 /  9890
4-1:  4890 / A: 16 B: 11 T: 27 /  9390
4-2:  7750 / A: 14 B: 15 T: 29 /  12250
5-1:  ---- / A: -- B: -- T: -- /  12940
*/
