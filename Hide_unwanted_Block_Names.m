[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Blocks = find_system(Model_Name,'Type','Block');
%-------------------Constant------------------------------
k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , 'Constant' );
     if str
         unwanted_constants(k)=All_Blocks(i);
         k=k+1;
      end
end
 if k>1
 unwanted_constants=transpose(unwanted_constants);
 end
 for i=1:length(unwanted_constants)
   set_param(char(unwanted_constants(i)), 'ShowName', 'off');  
 end
 %-------------------------------Product--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Product' );
     if str
         unwanted_Products(k)=All_Blocks(i);
         k=k+1;
      end
end
 if k>1
 unwanted_Products=transpose(unwanted_Products);
  for i=1:length(unwanted_Products)
   set_param(char(unwanted_Products(i)), 'ShowName', 'off');  
 end
 end

 
 %-------------------------------Terminator--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Terminator' );
     if str
         unwanted_Terminator(k)=All_Blocks(i);
         k=k+1;
      end
end
 if k>1
 unwanted_Terminator=transpose(unwanted_Terminator);
 for i=1:length(unwanted_Terminator)
   set_param(char(unwanted_Terminator(i)), 'ShowName', 'off');  
 end
 end
 
 
  %-------------------------------Terminator--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Ter0' );
     if str
         unwanted_Ter0(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Ter0=transpose(unwanted_Ter0);
 for i=1:length(unwanted_Ter0)
   set_param(char(unwanted_Ter0(i)), 'ShowName', 'off');  
 end
end
 %-------------------------------Add--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Add' );
     if str
         unwanted_Add(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
 unwanted_Add=transpose(unwanted_Add);
 for i=1:length(unwanted_Add)
   set_param(char(unwanted_Add(i)), 'ShowName', 'off');  
 end
 end
 %-------------------------------Gain--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Gain' );
     if str
         unwanted_Gain(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
 unwanted_Gain=transpose(unwanted_Gain);
 for i=1:length(unwanted_Gain)
   set_param(char(unwanted_Gain(i)), 'ShowName', 'off');  
 end
 end

 %-------------------------------Sum--------------
%  k=1;
% for i=1:length(All_Blocks)
%      str=contains( All_Blocks(i) , '/Sum' );
%      if str
%          unwanted_Sum(k)=All_Blocks(i);
%          k=k+1;
%       end
% end
% if k>1
% unwanted_Sum=transpose(unwanted_Sum);
% end
  %-------------------------------Subtract--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Subtract' );
     if str
         unwanted_Subtract(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
    unwanted_Subtract=transpose(unwanted_Subtract);
    for i=1:length(unwanted_Subtract)
   set_param(char(unwanted_Subtract(i)), 'ShowName', 'off');  
 end
end

  %-------------------------------Unary Minus--------------
 k=1;
 
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Unary Minus' );
     if str
         unwanted_Unary(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Unary=transpose(unwanted_Unary);
 for i=1:length(unwanted_Unary)
   set_param(char(unwanted_Unary(i)), 'ShowName', 'off');  
 end
end
  %-------------------------------Delay--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Delay' );
     if str
         unwanted_Delay(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Delay=transpose(unwanted_Delay);
for i=1:length(unwanted_Delay)
   set_param(char(unwanted_Delay(i)), 'ShowName', 'off');  
 end
end
 %-------------------------------Ground--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Ground' );
     if str
         unwanted_Ground(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Ground=transpose(unwanted_Ground);
for i=1:length(unwanted_Ground)
   set_param(char(unwanted_Ground(i)), 'ShowName', 'off');  
 end
end
 %-------------------------------Switch--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Switch' );
     if str
         unwanted_Switch(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Switch=transpose(unwanted_Switch);
for i=1:length(unwanted_Switch)
   set_param(char(unwanted_Switch(i)), 'ShowName', 'off');  
 end
end
  %-------------------------------RelationalOperator--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/RelationalOperator' );
     if str
         unwanted_RelationalOperator(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_RelationalOperator=transpose(unwanted_RelationalOperator);
for i=1:length(unwanted_RelationalOperator)
   set_param(char(unwanted_RelationalOperator(i)), 'ShowName', 'off');  
 end
end
 %-------------------------------LogicalOperator--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/LogicalOperator' );
     if str
         unwanted_LogicalOperator(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_LogicalOperator=transpose(unwanted_LogicalOperator);
for i=1:length(unwanted_LogicalOperator)
   set_param(char(unwanted_LogicalOperator(i)), 'ShowName', 'off');  
 end
end
%-------------------------------Memory--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Memory' );
     if str
         unwanted_Memory(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Memory=transpose(unwanted_Memory);
for i=1:length(unwanted_Memory)
   set_param(char(unwanted_Memory(i)), 'ShowName', 'off');  
 end
end
%-------------------------------Saturation--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Saturation' );
     if str
         unwanted_Saturation(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Saturation=transpose(unwanted_Saturation);
for i=1:length(unwanted_Saturation)
   set_param(char(unwanted_Saturation(i)), 'ShowName', 'off');  
 end
end
 %-------------------------------Subtract--------------
 k=1;
for i=1:length(All_Blocks)
     str=contains( All_Blocks(i) , '/Subtract' );
     if str
         unwanted_Subtract(k)=All_Blocks(i);
         k=k+1;
      end
end
if k>1
unwanted_Subtract=transpose(unwanted_Subtract);
for i=1:length(unwanted_Subtract)
   set_param(char(unwanted_Subtract(i)), 'ShowName', 'off');  
 end
 end
 