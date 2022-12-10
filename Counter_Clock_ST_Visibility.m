[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_subsystems	 = find_system(Model_Name,'SearchDepth',1,'BlockType','SubSystem');
k=1;
for i=1:length(All_subsystems)
    
if contains( All_subsystems(i) , 'IClock' )
    List(k)=All_subsystems(i);
    k=k+1;
end
end
List=transpose(List);
for i=1:length(List)
set_param(string(List(i)),'AttributesFormatString','ST = %<tsamp>\nMAX = %<uplimit>')

end
