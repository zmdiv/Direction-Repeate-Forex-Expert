input double volume = 0.1;

int intStopLoss = 15;
int intTakeProfit = 15;

input int LongMAPoints = 36;
input int ShortMAPoints = 8;

int ATRpoints = 5;

string LastOrderType = "";
string myResult = "";

double StopLoss = intStopLoss * 0.0001;
double TakeProfit = intTakeProfit * 0.0001;
double LastProfit;


////=========================================================
///==========================================================


double LongMA = iMA(NULL,PERIOD_M15,ShortMAPoints,0,MODE_SMA,PRICE_CLOSE,0);
double ShortMA = iMA(NULL,PERIOD_M15,LongMAPoints,0,MODE_SMA,PRICE_CLOSE,0);
double ShortShiftedMA = iMA(NULL,PERIOD_M5,20,0,MODE_SMA,PRICE_CLOSE,10);



long lastVolume15_1 = iVolume(NULL,15,1);
long lastVolume15_2 = iVolume(NULL,15,2);
long lastVolume15_3 = iVolume(NULL,15,3);
long AverageVolumes_15 = (lastVolume15_1 + lastVolume15_2 + lastVolume15_3) / 3;


double ATR_15 = iATR(_Symbol,PERIOD_M15,ATRpoints,1);


////=========================================================
///==========================================================



void OnInit()
{
 OrderSend(_Symbol,OP_BUY,0.1,Ask,3,(Ask-StopLoss),(Ask+TakeProfit), NULL,0,0,Green);  
}

  
void OnTick()
{


   if (ATR_15 < 0.0007)
   {
   Repeat();
   }

   else
   {
   AntiRepeat();
   }



}

//=========================
//=========================




void Repeat ()
 
{


              for (int i=OrdersHistoryTotal()-1; i>=0; i--)
              {
              
              //select an order
              
              OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);
             
              if (OrderSymbol() == _Symbol)
              
             
              if(i==OrdersHistoryTotal()-1)
              {
               // LastProfit = OrderProfit()+OrderSwap()+OrderCommission();
               
               if (OrderType()==OP_BUY) LastOrderType = "BUY-Order";
               if (OrderType()==OP_SELL) LastOrderType = "SELL-Order";
               
               
              }
              // store details in result
              // myResult = LastOrderType + "Profit:" + LastProfit;
              
             }




for (int j=OrdersHistoryTotal()-1; j >=0; j--)

   {
   OrderSelect(j,SELECT_BY_POS,MODE_HISTORY);
   
   if(OrderSymbol() == _Symbol)
   
     if (j == OrdersHistoryTotal()-1)
     
        {
         LastProfit = OrderProfit();
 
   if (OrdersTotal() == 0)
     {
          
         if (LastProfit < 0 && LastOrderType == "BUY-Order")
         {
         
         OrderSend(_Symbol,OP_SELL,volume,Bid,3,Bid+StopLoss,Bid-TakeProfit,NULL,0,0,Red);
         }
         
         
         else if (LastProfit < 0 && LastOrderType == "SELL-Order")
         {
        
         OrderSend(_Symbol,OP_BUY,volume,Ask,3,Ask-StopLoss,Ask+TakeProfit,NULL,0,0,Green); 
         }
         
          
         else if (LastProfit > 0 && LastOrderType == "BUY-Order")
         {
         OrderSend(_Symbol,OP_BUY,volume,Ask,3,Ask-StopLoss,Ask+TakeProfit,NULL,0,0,Green); 
         }
             
         else if (LastProfit > 0 && LastOrderType == "SELL-Order")
         {
         OrderSend(_Symbol,OP_SELL,volume,Bid,3,Bid+StopLoss,Bid-TakeProfit,NULL,0,0,Red);
         }
         
         
         
     }

}
}
}


//================================
//--------------------------------

 void AntiRepeat ()
 
{


              for (int i=OrdersHistoryTotal()-1; i>=0; i--)
              {
              
              //select an order
              
              OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);
             
              if (OrderSymbol() == _Symbol)
              
             
              if(i==OrdersHistoryTotal()-1)
              {
               // LastProfit = OrderProfit()+OrderSwap()+OrderCommission();
               
               if (OrderType()==OP_BUY) LastOrderType = "BUY-Order";
               if (OrderType()==OP_SELL) LastOrderType = "SELL-Order";
               
               
              }
              // store details in result
              // myResult = LastOrderType + "Profit:" + LastProfit;
              
             }




for (int j=OrdersHistoryTotal()-1; j >=0; j--)

   {
   OrderSelect(j,SELECT_BY_POS,MODE_HISTORY);
   
   if(OrderSymbol() == _Symbol)
   
     if (j == OrdersHistoryTotal()-1)
     
        {
         LastProfit = OrderProfit();
 
   if (OrdersTotal() == 0)
     {
          
         if (LastProfit < 0 && LastOrderType == "BUY-Order")
         {
         OrderSend(_Symbol,OP_BUY,volume,Ask,3,Ask-StopLoss,Ask+TakeProfit,NULL,0,0,Green); 
         }
         
         
         else if (LastProfit < 0 && LastOrderType == "SELL-Order")
         {
         OrderSend(_Symbol,OP_SELL,volume,Bid,3,Bid+StopLoss,Bid-TakeProfit,NULL,0,0,Red);
         }
         
          
         else if (LastProfit > 0 && LastOrderType == "BUY-Order")
         {
         OrderSend(_Symbol,OP_SELL,volume,Bid,3,Bid+StopLoss,Bid-TakeProfit,NULL,0,0,Red); 
         }
             
         else if (LastProfit > 0 && LastOrderType == "SELL-Order")
         {
         OrderSend(_Symbol,OP_BUY,volume,Ask,3,Ask-StopLoss,Ask+TakeProfit,NULL,0,0,Green);
         }
         
         
         
     }

}
}
}

