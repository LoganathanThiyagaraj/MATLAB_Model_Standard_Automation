
[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Blocks = find_system(Model_Name,'Type','Block');
k=1;
for i=1:length(All_Blocks)
    
if contains( All_Blocks(i) , 'Interval Test' )
    if contains( All_Blocks(i) , 'Dynamic' )
    else
    List(k)=All_Blocks(i);
    k=k+1;
    end
end
end
List=transpose(List);
for i=1:length(List)
set_param(string(List(i)),'AttributesFormatString','MAX = %<uplimit>\n MIN = %<lowlimit>' )
end

