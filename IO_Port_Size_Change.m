[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Inports = find_system(Model_Name,'BlockType','Inport');
All_Outports = find_system(Model_Name,'BlockType','Outport');
%Inport Size
    for Inport_list_index=1:length(All_Inports)
     Position=get_param(All_Inports{Inport_list_index},'position');
      set_param(All_Inports{Inport_list_index},'position',[Position(1),Position(2),Position(1)+30,Position(2)+14]);
    end
%Outport Size    
   for Outport_list_index=1:length(All_Outports)
     Position=get_param(All_Outports{Outport_list_index},'position');
      set_param(All_Outports{Outport_list_index},'position',[Position(1),Position(2),Position(1)+30,Position(2)+14]);
    end

     
