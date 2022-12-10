[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Inports = find_system(Model_Name,'BlockType','Inport');
All_Outports = find_system(Model_Name,'BlockType','Outport');


%% Inports  
    for Inport_list_index=1:length(All_Inports)
     set_param(All_Inports{Inport_list_index},'BackgroundColor','Green');
      set_param(All_Inports{Inport_list_index},'ForegroundColor','Black');
    end

%% Outports
    for Outport_list_index=1:length(All_Outports)
      set_param(All_Outports{Outport_list_index},'BackgroundColor','Orange');
       set_param(All_Outports{Outport_list_index},'ForegroundColor','Black');
    end
     
