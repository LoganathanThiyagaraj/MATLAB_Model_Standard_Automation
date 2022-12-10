[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Saturat_block = find_system(Model_Name,'BlockType','Saturate');
for i=1:length(All_Saturat_block)
set_param(string(All_Saturat_block(i)),'AttributesFormatString','MAX = %<UpperLimit>\n MIN = %<LowerLimit>' )
end