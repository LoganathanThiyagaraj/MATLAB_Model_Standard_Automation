[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Blocks	 = find_system(Model_Name,'Type','Block');
for i = 1:length(All_Blocks)
       set_param(char(All_Blocks(i)),'FontSize','10')
        set_param(char(All_Blocks(i)),'FontName','Arial')
        set_param(char(All_Blocks(i)),'FontWeight','Normal')
end
lines = get_param(Model_Name,'Lines'); 
for i = 1:length(lines) 
      set_param(lines(i).Handle,'FontSize','9') 
      set_param(lines(i).Handle,'FontName','Arial')
      set_param(lines(i).Handle,'FontWeight','Normal')
end 