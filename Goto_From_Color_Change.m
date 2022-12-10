

[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Goto = find_system(Model_Name,'BlockType','Goto');
All_From = find_system(Model_Name,'BlockType','From');
%% Goto  

    for Goto_list_index=1:length(All_Goto)
     set_param(All_Goto{Goto_list_index},'BackgroundColor','Green');
      set_param(All_Goto{Goto_list_index},'ForegroundColor','Black');
    end

%% From

    for From_list_index=1:length(All_From)
      set_param(All_From{From_list_index},'BackgroundColor','Green');
       set_param(All_From{From_list_index},'ForegroundColor','Black');
    end
     
