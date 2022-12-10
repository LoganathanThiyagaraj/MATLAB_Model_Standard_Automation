

[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Blocks = find_system(Model_Name,'Type','Block');

%%   

    for list_index=1:length(All_Blocks)
     set_param(All_Blocks{list_index},'BackgroundColor','White');
      set_param(All_Blocks{list_index},'ForegroundColor','Black');
    end

