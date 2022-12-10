[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_UnitDelay_block = find_system(Model_Name,'BlockType','UnitDelay');
for i=1:length(All_UnitDelay_block)
set_param(string(All_UnitDelay_block(i)),'AttributesFormatString','IC = %<InitialCondition>' )
end
All_Delay_block = find_system(Model_Name,'BlockType','Delay');
for i=1:length(All_Delay_block)
set_param(string(All_Delay_block(i)),'AttributesFormatString','IC = %<InitialCondition>' )
end
All_TransportDelay_block = find_system(Model_Name,'BlockType','TransportDelay');
for i=1:length(All_TransportDelay_block)
set_param(string(All_TransportDelay_block(i)),'AttributesFormatString','IO = %<InitialOutput>' )
end