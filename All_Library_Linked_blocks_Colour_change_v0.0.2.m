[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Blocks = find_system(Model_Name,'Type','Block');
k=1;
get_param(gcb, 'StaticLinkStatus')
 for i=1:length(All_Blocks)
  linked_Status(k)=get_param(All_Blocks(i),'StaticLinkStatus');
k=k+1;
 end
 k=1;

 for i=1:length(linked_Status)
     if strcmp(linked_Status(i),'resolved')    
         linked_Blocks(k)=All_Blocks(i);
          k=k+1;
      end
 end
  Info=libinfo(linked_Blocks);
  k=1;
  linked_Blocks=transpose(linked_Blocks);
for i=1:length(linked_Blocks)  
    ch=Info(i).Library;
  if strcmp( ch,'Lib_Common') || strcmp( ch,'Renault_Library') || strcmp( ch,'CanCorrectLibrary')
      Final_list(k,1)=linked_Blocks(i);   
      k=k+1;
  end
end


for Library_Blocks_list=1:length(Final_list)
      set_param(Final_list{Library_Blocks_list},'BackgroundColor','Yellow');
       set_param(Final_list{Library_Blocks_list},'ForegroundColor','Black');
end
k=1;
for i=1:length(linked_Blocks)  
    ch=Info(i).Library;
  if strcmp( ch,'simulink')
      simulink_list(k,1)=linked_Blocks(i);   
      k=k+1;
  end
end
for Simulink_Library_list=1:length(simulink_list)
      set_param(simulink_list{Simulink_Library_list},'BackgroundColor','White');
       set_param(simulink_list{Simulink_Library_list},'ForegroundColor','Black');
end