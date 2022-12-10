%This script is used to extract label/propagation for the connection blocks which
%supports signal propagation property.(This script extracts data from 'Searchdepth 2')
%Note--->This script doesnot include 'Enable','Trigger','function split call'and 'signal propagation' blocks

%For 'subsystem and stateflow', It is only checked whether  propagtion is present for outport handle and propagation/label is present for inport handle
%of the subsystem.It needs to be manually checked whether provided propagation/label is correct or not



%for more info visit-->https://in.mathworks.com/help/simulink/ug/signal-label-propagation.html


function Copy_of_label_Check_v_0_0_2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %Inputs and Outputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
get_path_top_Level_Inputs= find_system(gcs,'SearchDepth',1,'BlockType','Inport');
SubSys_name = get_param(get_path_top_Level_Inputs{1}, 'PortConnectivity');
dstBlkName = get_param(SubSys_name(1).DstBlock, 'Name');
Inner_path= strcat(gcs,'/',char(dstBlkName));
Inputs={};
Input_porthandles={};
Input_data={};
Input_lines={};
Input_str={};
final_data_Inputs={};
Input_tag_name={};
Dst_port_handle_Input={};
Input_label={};
Input_PropagatedSignal={};
Input_port_connectivity={};
Input_Dst_block_type= {};
Input_src_tag_name={};
Input_Dst_name={};
Input_Mask_status={};
name= gcs;%common parameter for all;
source_block_handle_Input={};
source_block_name_Input={};
Inputs= find_system(Inner_path, 'BlockType', 'Inport');

for i=1:length(Inputs)
Input_porthandles = get_param(Inputs{i}, 'PortHandles');
Input_port_connectivity{i}= get_param(Inputs{i}, 'PortConnectivity');
Input_Dst_block_type{i}= get_param(Input_port_connectivity{i}.DstBlock, 'BlockType');
%Input_src_tag_name{i}= get_param(Input_port_connectivity{i}.SrcBlock, 'Tag');
Input_Dst_name{i}= get_param(Input_port_connectivity{i}.DstBlock, 'Name');
%Input_Mask_status{i}= get_param(Input_port_connectivity{i}.DstBlock,'Mask');

Input_tag_name{i}= get_param(Inputs{i},'Name');
Input_Blk_Type{i}= get_param(Inputs{i},'BlockType');
Input_lines{i} = get_param(Input_porthandles.Outport, 'Line');
source_block_handle_Input{i}=get_param(Input_lines{i}, 'SrcBlockHandle');
source_block_name_Input{i}=get_param(source_block_handle_Input{i}, 'Name');
Dst_port_handle_Input = get_param(Input_lines{i},'DstPortHandle');
Input_label{i}= get_param(Input_lines{i},'name');
%Input_PropagatedSignal{i}=get(Dst_port_handle_Input,'PropagatedSignals');
Input_PropagatedSignal{i}=get(Input_porthandles.Outport,'PropagatedSignals');
Input_data=get(Input_lines{i},'signalPropagation');

if strcmp(Input_data,'off')
    Input_str{i}= Input_label{i};
else strcmp(Input_data,'on')
    Input_str{i}= strcat(Input_label{i},'<',Input_PropagatedSignal{i},'>');
end    

end
Input_data= Input_data';
Input_label= Input_label';
Input_str= Input_str';
Input_tag_name= Input_tag_name';
Input_PropagatedSignal=Input_PropagatedSignal';
Input_lines= Input_lines';
Input_port_connectivity=Input_port_connectivity';
Input_Dst_block_type=Input_Dst_block_type';
Input_src_tag_name=Input_src_tag_name';
Input_Dst_name=Input_Dst_name';
Input_Mask_status=Input_Mask_status';
source_block_handle_Input=source_block_handle_Input';
source_block_name_Input=source_block_name_Input';

for i=1:length(Inputs)
    final_data_Inputs{i,6}='--';
    final_data_Inputs{i,1}=Inputs{i};
    final_data_Inputs{i,2}=Input_Blk_Type{i};
    final_data_Inputs{i,3}=Input_tag_name{i};
    final_data_Inputs{i,4}=Input_str{i};
    if(isempty(Input_str{i}))
     final_data_Inputs{i,5}='NG';
     final_data_Inputs{i,6}='No Label/propagation';
    elseif(~strcmp(Input_tag_name{i},Input_PropagatedSignal{i}))&& (~isempty(Input_PropagatedSignal{i}))&&(contains(Input_str{i},'<'))
        final_data_Inputs{i,5}='NG';
    elseif((~isempty(Input_label{i})) && (contains(Input_str{i},'<')))
      final_data_Inputs{i,5}='NG';
    elseif(isempty(Input_label{i})) && (contains(Input_str{i},'<'))&&(strcmp(Input_tag_name{i},Input_PropagatedSignal{i}))
      final_data_Inputs{i,5}= 'OK';  %'Propagation';
    elseif(~isempty(Input_label{i}))&& ~(contains(Input_str{i},'<'))&& (strcmp(Input_tag_name{i},Input_label{i}))
       final_data_Inputs{i,5}= 'OK';  %'Label present'; 
	%elseif(~isempty(Input_label{i}))&& (contains(Input_str{i},'<'))&& (contains(Input_label{i},'<'))&& (strcmp(Input_src_block_type{i},'BusSelector'))
	  % final_data_Inputs{i,4}='OK';  %'Bus label';
    else
       final_data_Inputs{i,5}='NG'; 
        
end
end
 
 for i=1:length(Inputs)
      final_data_Inputs{i,1}=Inputs{i};
      final_data_Inputs{i,3}=Input_tag_name{i};
     final_data_Inputs{i,4}=Input_str{i};
        if strcmp(final_data_Inputs{i,5},'OK')
           if(~isempty(Input_label{i})&& ~(contains(Input_str{i},'<'))&& (strcmp(Input_tag_name{i},Input_label{i})))
              % if(strcmp(Input_label{i},source_block_name_Input{i}))
                   final_data_Inputs{i,5}='NG'; %if source block name is same then propagation must be present
                   final_data_Outport{i,6}='Propagation required';
              % end
           end
        end
 end
 
                
    writedata= {'Block path','BlockType','Name/Tag Name/Subsystem','Propagation/label' ,'Result','Remarks'};   
    writedata= [writedata;final_data_Inputs];
        
          
Outputs={};
Outport_porthandles={};
Outport_data={};
Outport_lines={};
Outport_str={};
final_data_Outport={};
Outport_tag_name={};
Outport_src_port_handle={};
Outport_label={};
Outport_PropagatedSignal={};
Outport_port_connectivity={};
Outport_src_block_type= {};
Outport_src_tag_name={};
Outport_src_name={};
Outport_Mask_status={};

name= gcs;%%%%%%%%%%%%%%%%%common for all

Outputs= find_system(Inner_path, 'BlockType', 'Outport');
if ~isempty(Outputs)

for i=1:length(Outputs)
Outport_porthandles = get_param(Outputs{i}, 'PortHandles');
Outport_Blk_Type{i}= get_param(Outputs{i},'BlockType');
Outport_port_connectivity{i}= get_param(Outputs{i}, 'PortConnectivity');
Outport_src_block_type{i}= get_param(Outport_port_connectivity{i}.SrcBlock, 'BlockType');
Outport_src_tag_name{i}= get_param(Outport_port_connectivity{i}.SrcBlock, 'Tag');
Outport_src_name{i}= get_param(Outport_port_connectivity{i}.SrcBlock, 'Name');
Outport_Mask_status{i}= get_param(Outport_port_connectivity{i}.SrcBlock,'Mask');
%goto_data{i}=get(goto_porthandles.Inport,'PropagatedSignals');
Outport_tag_name{i}= get_param(Outputs{i},'name');
Outport_lines{i} = get_param(Outport_porthandles.Inport, 'Line');
Outport_src_port_handle = get_param(Outport_lines{i},'SrcPortHandle');
Outport_label{i}= get_param(Outport_lines{i},'name');
Outport_PropagatedSignal{i}=get(Outport_src_port_handle,'PropagatedSignals');
Outport_data=get(Outport_lines{i},'signalPropagation');

if strcmp(Outport_data,'off')
    Outport_str{i}= Outport_label{i};
else strcmp(Outport_data,'on')
    Outport_str{i}= strcat(Outport_label{i},'<',Outport_PropagatedSignal{i},'>');
end    

end
Outport_data= Outport_data';
Outport_label= Outport_label';
Outport_str= Outport_str';
Outport_tag_name= Outport_tag_name';
Outport_PropagatedSignal=Outport_PropagatedSignal';
Outport_lines= Outport_lines';
Outport_port_connectivity=Outport_port_connectivity';
Outport_src_block_type=Outport_src_block_type';
Outport_src_tag_name=Outport_src_tag_name';
Outport_src_name=Outport_src_name';
Outport_Mask_status=Outport_Mask_status';

for i=1:length(Outputs)
    final_data_Outport{i,6}='--';
    final_data_Outport{i,1}=Outputs{i};
    final_data_Outport{i,2}=Outport_Blk_Type{i};
    final_data_Outport{i,3}=Outport_tag_name{i};
    final_data_Outport{i,4}=Outport_str{i};
    if(isempty(Outport_str{i}))
     final_data_Outport{i,5}='NG';
     final_data_Outport{i,6}='No Label/propagation';
    elseif(~strcmp(Outport_tag_name{i},Outport_PropagatedSignal{i}))&& (~isempty(Outport_PropagatedSignal{i}))&&(contains(Outport_str{i},'<'))
        final_data_Outport{i,5}='NG';
    elseif(~isempty(Outport_label{i})) && (contains(Outport_str{i},'<'))&& ~strcmp(Outport_src_block_type{i},'BusSelector')
      final_data_Outport{i,5}='NG';
    elseif(isempty(Outport_label{i})) && (contains(Outport_str{i},'<'))&&(strcmp(Outport_tag_name{i},Outport_PropagatedSignal{i}))
      final_data_Outport{i,5}= 'OK';  %'Propagation';
    elseif(~isempty(Outport_label{i}))&& ~(contains(Outport_str{i},'<'))&& (strcmp(Outport_tag_name{i},Outport_label{i}))
       final_data_Outport{i,5}= 'OK';  %'Label present'; 
	elseif(~isempty(Outport_label{i}))&& (contains(Outport_str{i},'<'))&& (contains(Outport_label{i},'<'))&& (strcmp(Outport_src_block_type{i},'BusSelector'))
	   final_data_Outport{i,5}='OK';  %'Bus label';
    else
       final_data_Outport{i,5}='NG'; 
        
end
end
 
for i=1:length(Outputs)
    final_data_Outport{i,1}=Outputs{i};
    final_data_Outport{i,3}=Outport_tag_name{i};
    final_data_Outport{i,4}=Outport_str{i};
    
if  (strcmp(Outport_src_block_type{i},'SubSystem') && (~strcmp(Outport_src_tag_name{i},'[LIB]') ||  ~(contains(Outport_src_name{i},'RSA'))) &&( ~strcmp(Outport_Mask_status{i},'on')))%check for subsystem type 
    if strcmp(final_data_Outport{i,5},'OK')
        if (~isempty(Outport_label{i})&& ~(contains(Outport_str{i},'<'))&& (strcmp(Outport_tag_name{i},Outport_label{i})))
           
        final_data_Outport{i,5}='NG'; %for subsystem output propagation must be present
        final_data_Outport{i,6}='Propagation required';
        end
    end
end
end
end

writedata= [writedata;final_data_Outport];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %Goto and From
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

goto={};
goto_porthandles={};
goto_data={};
goto_lines={};
goto_str={};
final_data_goto={};
goto_tag_name={};
src_port_handle={};
goto_label={};
goto_PropagatedSignal={};
goto_port_connectivity={};
goto_src_block_type= {};
goto_src_tag_name={};
goto_src_name={};
Mask_status={};
name= gcs;
goto= find_system(Inner_path, 'BlockType', 'Goto');
if ~isempty(goto)

for i=1:length(goto)
goto_porthandles = get_param(goto{i}, 'PortHandles');
goto_Blk_Type{i}= get_param(goto{i},'BlockType');
goto_port_connectivity{i}= get_param(goto{i}, 'PortConnectivity');
goto_src_block_type{i}= get_param(goto_port_connectivity{i}.SrcBlock, 'BlockType');
goto_src_tag_name{i}= get_param(goto_port_connectivity{i}.SrcBlock, 'Tag');
goto_src_name{i}= get_param(goto_port_connectivity{i}.SrcBlock, 'Name');
Mask_status{i}= get_param(goto_port_connectivity{i}.SrcBlock,'Mask');
%goto_data{i}=get(goto_porthandles.Inport,'PropagatedSignals');
goto_tag_name{i}= get_param(goto{i},'GotoTag');
goto_lines{i} = get_param(goto_porthandles.Inport, 'Line');
src_port_handle = get_param(goto_lines{i},'SrcPortHandle');
goto_label{i}= get_param(goto_lines{i},'name');
goto_PropagatedSignal{i}=get(src_port_handle,'PropagatedSignals');
goto_data=get(goto_lines{i},'signalPropagation');

if strcmp(goto_data,'off')
    goto_str{i}= goto_label{i};
else strcmp(goto_data,'on')
    goto_str{i}= strcat(goto_label{i},'<',goto_PropagatedSignal{i},'>');
end    

end
goto_data= goto_data';
goto_label= goto_label';
goto_str= goto_str';
goto_tag_name= goto_tag_name';
goto_PropagatedSignal=goto_PropagatedSignal';
goto_lines= goto_lines';
goto_port_connectivity=goto_port_connectivity';
goto_src_block_type=goto_src_block_type';
goto_src_tag_name=goto_src_tag_name';
goto_src_name=goto_src_name';
Mask_status=Mask_status';

for i=1:length(goto)
    final_data_goto{i,6}='--';
    final_data_goto{i,1}=goto{i};
    final_data_goto{i,2}=goto_Blk_Type{i};
    final_data_goto{i,3}=goto_tag_name{i};
    final_data_goto{i,4}=goto_str{i};
    if(isempty(goto_str{i}))
     final_data_goto{i,5}='NG';
     final_data_goto{i,6}='No Label/propagation';
    elseif(~strcmp(goto_tag_name{i},goto_PropagatedSignal{i}))&& (~isempty(goto_PropagatedSignal{i}))&&(contains(goto_str{i},'<'))
        final_data_goto{i,5}='NG';
    elseif(~isempty(goto_label{i})) && (contains(goto_str{i},'<'))&& ~strcmp(goto_src_block_type{i},'BusSelector')
      final_data_goto{i,5}='NG';
    elseif(isempty(goto_label{i})) && (contains(goto_str{i},'<'))&&(strcmp(goto_tag_name{i},goto_PropagatedSignal{i}))
      final_data_goto{i,5}= 'OK';  %'Propagation';
    elseif(~isempty(goto_label{i}))&& ~(contains(goto_str{i},'<'))&& (strcmp(goto_tag_name{i},goto_label{i}))
       final_data_goto{i,5}= 'OK';  %'Label present'; 
	elseif(~isempty(goto_label{i}))&& (contains(goto_str{i},'<'))&& (contains(goto_label{i},'<'))&& (strcmp(goto_src_block_type{i},'BusSelector'))
	   final_data_goto{i,5}='OK';  %'Bus label';
    else
       final_data_goto{i,5}='NG'; 
        
end
end
 
for i=1:length(goto)
   
    final_data_goto{i,1}=goto{i};
    final_data_goto{i,3}=goto_tag_name{i};
    final_data_goto{i,4}=goto_str{i};
if  (strcmp(goto_src_block_type{i},'SubSystem') && (~strcmp(goto_src_tag_name{i},'[LIB]') ||  ~(contains(goto_src_name{i},'RSA'))) &&( ~strcmp(Mask_status{i},'on')))%check for subsystem type 
    if strcmp(final_data_goto{i,5},'OK')
        if (~isempty(goto_label{i})&& ~(contains(goto_str{i},'<'))&& (strcmp(goto_tag_name{i},goto_label{i})))
           
        final_data_goto{i,5}='NG'; %for subsystem output propagation must be present
        final_data_goto{i,6}='Propagation required';
        end
    end
end
end
end            
writedata= [writedata;final_data_goto];       
        
       
        


from= {};
from_porthandles={};
from_data={};
from_lines={};
from_label={};
from_str={};
from_tag_name={};
final_data_from={};
from_PropagatedSignal={};


from= find_system(Inner_path, 'BlockType', 'From');
if ~isempty(from)
for i=1:length(from)
from_porthandles = get_param(from{i}, 'PortHandles');
from_Blk_Type{i}= get_param(from{i},'BlockType');
from_tag_name{i}= get_param(from{i},'GotoTag');
from_PropagatedSignal{i}=get(from_porthandles.Outport,'PropagatedSignals');
from_lines{i} = get_param(from_porthandles.Outport, 'Line');
from_label{i}= get_param(from_lines{i},'name');
from_data =get(from_lines{i},'signalPropagation');
if strcmp(from_data,'off')
    from_str{i}= from_label{i};
else strcmp(from_data,'on')
    from_str{i}= strcat(from_label{i},'<',from_PropagatedSignal{i},'>');
end    

end

from_data= from_data';
from_label= from_label';
from_str= from_str';
from_tag_name= from_tag_name';
from_PropagatedSignal=from_PropagatedSignal';
from_lines=from_lines';

for i=1:length(from)
    final_data_from{i,6}='--';
    final_data_from{i,1}=from{i};
    final_data_from{i,2}=from_Blk_Type{i};
    final_data_from{i,3}=from_tag_name{i};
    final_data_from{i,4}=from_str{i};
    if(isempty(from_str{i}))
     final_data_from{i,5}='NG';
     final_data_from{i,6}='No Label/propagation';
    elseif(~strcmp(from_tag_name{i},from_PropagatedSignal{i}))&& (~isempty(from_PropagatedSignal{i}))&& (contains(from_str{i},'<'))
        final_data_from{i,5}='NG';
    elseif(~isempty(from_label{i})) && (contains(from_str{i},'<'))
      final_data_from{i,5}='NG';
    elseif(isempty(from_label{i})) && (contains(from_str{i},'<')) && (strcmp(from_tag_name{i},from_PropagatedSignal{i}))
      final_data_from{i,5}='OK'; %'Propagation';
    elseif(~isempty(from_label{i}))&& ~(contains(from_str{i},'<'))&& (strcmp(from_tag_name{i},from_label{i}))
       final_data_from{i,5}= 'OK'; %'Label present';
    else
        final_data_from{i,5}='NG';
end
end
for i=1:length(from)
    if(strcmp(final_data_from{i,5},'OK'))
        if(~isempty(from_label{i}))&& ~(contains(from_str{i},'<'))&& (strcmp(from_tag_name{i},from_label{i}))
            final_data_from{i,5}='NG';%Propagation must be present for the output line handle in case of from blocks
            final_data_from{i,6}='Propagation required';
        end
    end
end
end
   

writedata= [writedata;final_data_from]; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %Subsystem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



SubNew=1;
Subsystem_str={};
subsystem= find_system(Inner_path, 'BlockType', 'SubSystem');
for i=1:length(subsystem)
    Mask_status_subsys{i}= get_param(subsystem{i},'Mask');
    Subsys_name{i}=get_param(subsystem{i},'Name');
    Subsys_Tag{i}= get_param(subsystem{i},'Tag');
     Subsys_ErrorFcn{i}= get_param(subsystem{i},'ErrorFcn');
    if((~contains(Subsys_Tag{i},'[LIB]') ||  ~(contains(Subsys_name{i},'RSA'))) &&( ~strcmp(Mask_status_subsys{i},'on')) &&(~strcmp(Subsys_ErrorFcn{i},'Stateflow.Translate.translate')))
        Subsystem{SubNew}=subsystem{i};
        SubNew=SubNew+1;
    end
end
    %clear SubNew;
  Subsystem(:,1)=[];%------------------------------->>>>Exclude for 2nd level Subsystem
  Subsystem= Subsystem';  
    

if ~isempty(Subsystem)
    k=1;
for i=1:length(Subsystem)

Subsystem_porthandles = get_param(Subsystem{i}, 'PortHandles');

width_Inport=length(Subsystem_porthandles.Inport);
for j=1:width_Inport
Subsys_path{k}= Subsystem{i};
Subsys_Blk_Type{k}= get_param(Subsystem{i},'BlockType');   
Subsystem_lines_Inport= get_param(Subsystem_porthandles.Inport(1,j), 'Line');
Subsys_src_port_handle_Inport = get_param(Subsystem_lines_Inport,'SrcPortHandle');
Subsystem_PropagatedSignal{k}=get_param(Subsys_src_port_handle_Inport,'PropagatedSignals');
Subsys_blk_name{k}= get_param(Subsystem{i},'Name');
Subsystem_label{k}= get_param(Subsystem_lines_Inport,'name');
Subsystem_data=get(Subsystem_lines_Inport,'signalPropagation');


if strcmp(Subsystem_data,'off')
    Subsystem_str{k,1}= Subsystem_label{k};
    Subsystem_str{k,2}= 'label_OK';
else strcmp(Subsystem_data,'on')
    Subsystem_str{k,1}= strcat(Subsystem_label{k},'<',Subsystem_PropagatedSignal{k},'>');
    Subsystem_str{k,2}= 'label_OK';
end

k=k+1;
end
%clear width_Inport;


width_Outport=length(Subsystem_porthandles.Outport);

for j=1:width_Outport
Subsys_path{k}= Subsystem{i};   
Subsys_Blk_Type{k}= get_param(Subsystem{i},'BlockType');     
Subsystem_PropagatedSignal{k}= get_param(Subsystem_porthandles.Outport(1,j), 'PropagatedSignals');
Subsystem_lines_Outport= get_param(Subsystem_porthandles.Outport(1,j),'Line');
Subsys_blk_name{k}= get_param(Subsystem{i},'Name');   
Subsystem_label{k}= get_param(Subsystem_lines_Outport,'name');
Subsystem_data=get(Subsystem_lines_Outport,'signalPropagation');

if strcmp(Subsystem_data,'off')
    Subsystem_str{k,1}= Subsystem_label{k};
     Subsystem_str{k,2}= 'label_NG';
else strcmp(Subsystem_data,'on')
    Subsystem_str{k,1}= strcat(Subsystem_label{k},'<',Subsystem_PropagatedSignal{k},'>');
    Subsystem_str{k,2}= 'label_NG';
end
k=k+1;
end


%clear width_Outport;


end
end
Subsystem_data= Subsystem_data';
Subsystem_label= Subsystem_label';
%Subsystem_str= Subsystem_str';
Subsys_blk_name=Subsys_blk_name';


[row_subsys, col_subsys]=size(Subsystem_str);

for i=1:row_subsys
    final_data_Subsystem{i,6}='--';
    final_data_Subsystem{i,1}=Subsys_path{i};
    final_data_Subsystem{i,2}=Subsys_Blk_Type{i};
    final_data_Subsystem{i,3}=Subsys_blk_name{i};
    final_data_Subsystem{i,4}=Subsystem_str{i,1};
    if(isempty(Subsystem_str{i,1}))
     final_data_Subsystem{i,5}='NG';%No_label/Propagation
     final_data_Subsystem{i,6}='No Label/propagation';
    elseif(~isempty(Subsystem_label{i}))&& (~isempty(Subsystem_PropagatedSignal{i}))&&(contains(Subsystem_str{i,1},'<'))
        final_data_Subsystem{i,5}='NG';
    elseif(isempty(Subsystem_label{i})) && (contains(Subsystem_str{i,1},'<'))&&(~isempty(Subsystem_PropagatedSignal{i}))
      final_data_Subsystem{i,5}= 'OK';  %'Propagation';
    elseif(~isempty(Subsystem_label{i}))&& ~(contains(Subsystem_str{i,1},'<'))&& (isempty(Subsystem_PropagatedSignal{i}))&& strcmp(Subsystem_str{i,2},'label_OK')
       final_data_Subsystem{i,5}= 'OK';  %'Label present/Label is OK'; 
	%elseif(~isempty(Subsystem_label{i}))&& ~(contains(Subsystem_str{i,1},'<'))&& (isempty(Subsystem_PropagatedSignal{i}))&& strcmp(Subsystem_str{i,2},'label_NG')
    elseif(~isempty(Subsystem_label{i}))&& ~(contains(Subsystem_str{i,1},'<'))&& strcmp(Subsystem_str{i,2},'label_NG')
       final_data_Subsystem{i,5}= 'NG';  %'Propagation required';
       final_data_Subsystem{i,6}= 'Propagation required';
    else
       final_data_Subsystem{i,5}='NG'; 
        
    end
end
 
clear k;
writedata= [writedata;final_data_Subsystem]; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %Stateflow(Subsystem)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



Stateflow_count=1;
Stateflow_Subsystem= find_system(Inner_path, 'BlockType', 'SubSystem');
for i=1:length(Stateflow_Subsystem)
    Mask_status_Stateflow{i}= get_param(Stateflow_Subsystem{i},'Mask');
    Stateflow_name{i}=get_param(Stateflow_Subsystem{i},'Name');
    Staeflow_Tag{i}= get_param(Stateflow_Subsystem{i},'Tag');
    Stateflow_ErrorFcn{i}= get_param(Stateflow_Subsystem{i},'ErrorFcn');
    if((~contains(Staeflow_Tag{i},'[LIB]') ||  ~(contains(Stateflow_name{i},'RSA'))) &&( ~strcmp(Mask_status_Stateflow{i},'on')) &&(strcmp(Stateflow_ErrorFcn{i},'Stateflow.Translate.translate')))
        StateFlow_Subsystem{Stateflow_count}=Stateflow_Subsystem{i};
        Stateflow_count=Stateflow_count+1;
    end
end
    
if(Stateflow_count>1)
  
  StateFlow_Subsystem= StateFlow_Subsystem';  
    
    

if ~isempty(StateFlow_Subsystem)
    k=1;
for i=1:length(StateFlow_Subsystem)

Stateflow_porthandles = get_param(StateFlow_Subsystem{i}, 'PortHandles');

width_Inport=length(Stateflow_porthandles.Inport);
for j=1:width_Inport
Stateflow_path{k}= StateFlow_Subsystem{i};
Stateflow_Blk_Type{k}= get_param(StateFlow_Subsystem{i},'BlockType');
Stateflow_Blk_Type{k}= strcat('Stateflow_',Stateflow_Blk_Type{k});
Stateflow_lines_Inport= get_param(Stateflow_porthandles.Inport(1,j), 'Line');
Stateflow_src_port_handle_Inport = get_param(Stateflow_lines_Inport,'SrcPortHandle');
Stateflow_PropagatedSignal{k}=get_param(Stateflow_src_port_handle_Inport,'PropagatedSignals');
Stateflow_blk_name{k}= get_param(StateFlow_Subsystem{i},'Name');
Stateflow_label{k}= get_param(Stateflow_lines_Inport,'name');
Stateflow_data=get(Stateflow_lines_Inport,'signalPropagation');


if strcmp(Stateflow_data,'off')
    Stateflow_str{k,1}= Stateflow_label{k};
    Stateflow_str{k,2}= 'label_OK';
else strcmp(Stateflow_data,'on')
    Stateflow_str{k,1}= strcat(Stateflow_label{k},'<',Stateflow_PropagatedSignal{k},'>');
    Stateflow_str{k,2}= 'label_OK';
end

k=k+1;
end
%clear ;


Stateflow_width_Outport=length(Stateflow_porthandles.Outport);

for j=1:Stateflow_width_Outport
Stateflow_path{k}= StateFlow_Subsystem{i};   
Stateflow_Blk_Type{k}= get_param(StateFlow_Subsystem{i},'BlockType');  
Stateflow_Blk_Type{k}= strcat('Stateflow_',Stateflow_Blk_Type{k});
Stateflow_PropagatedSignal{k}= get_param(Stateflow_porthandles.Outport(1,j), 'PropagatedSignals');
Stateflow_lines_Outport= get_param(Stateflow_porthandles.Outport(1,j),'Line');
Stateflow_blk_name{k}= get_param(StateFlow_Subsystem{i},'Name');   
Stateflow_label{k}= get_param(Stateflow_lines_Outport,'name');
Stateflow_data=get(Stateflow_lines_Outport,'signalPropagation');

if strcmp(Stateflow_data,'off')
    Stateflow_str{k,1}= Stateflow_label{k};
     Stateflow_str{k,2}= 'label_NG';
else strcmp(Stateflow_data,'on')
    Stateflow_str{k,1}= strcat(Stateflow_label{k},'<',Stateflow_PropagatedSignal{k},'>');
    Stateflow_str{k,2}= 'label_NG';
end
k=k+1;
end


%clear Stateflow_width_Outport;


end
end
Stateflow_data= Stateflow_data';
Stateflow_label= Stateflow_label';
%Subsystem_str= Subsystem_str';
Stateflow_blk_name=Stateflow_blk_name';




for i=1:length(Stateflow_str)
    final_data_Stateflow{i,6}='--';
    final_data_Stateflow{i,1}=Stateflow_path{i};
    final_data_Stateflow{i,2}=Stateflow_Blk_Type{i};
    final_data_Stateflow{i,3}=Stateflow_blk_name{i};
    final_data_Stateflow{i,4}=Stateflow_str{i,1};
    if(isempty(Stateflow_str{i,1}))
     final_data_Stateflow{i,5}='NG';%No_label/Propagation
     final_data_Stateflow{i,6}='No Label/propagation';
    elseif(~isempty(Stateflow_label{i}))&& (~isempty(Stateflow_PropagatedSignal{i}))&&(contains(Stateflow_str{i,1},'<'))
        final_data_Stateflow{i,5}='NG';
    elseif(isempty(Stateflow_label{i})) && (contains(Stateflow_str{i,1},'<'))&&(~isempty(Stateflow_PropagatedSignal{i}))
      final_data_Stateflow{i,5}= 'OK';  %'Propagation';
    elseif(~isempty(Stateflow_label{i}))&& ~(contains(Stateflow_str{i,1},'<'))&& (isempty(Stateflow_PropagatedSignal{i}))&& strcmp(Stateflow_str{i,2},'label_OK')
       final_data_Stateflow{i,5}= 'OK';  %'Label present/Label is OK'; 
	%elseif(~isempty(Stateflow_label{i}))&& ~(contains(Stateflow_str{i,1},'<'))&& (isempty(Stateflow_PropagatedSignal{i}))&& strcmp(Stateflow_str{i,2},'label_NG')
    elseif(~isempty(Stateflow_label{i}))&& ~(contains(Stateflow_str{i,1},'<'))&& strcmp(Stateflow_str{i,2},'label_NG')
       final_data_Stateflow{i,5}= 'NG';  %'Propagation required';
       final_data_Stateflow{i,6}= 'Propagation required';
    else
       final_data_Stateflow{i,5}='NG'; 
        
    end
end
 
%clear k;

         
writedata= [writedata;final_data_Stateflow]; 
 end 




%%%%%%Write to Excel_File%%%%%%%%%%%%%%%
file_name= strcat(name,'_Label_Check');
try
xlswrite(file_name,writedata,'Sheet1');
catch ME
    ME.cause
    ME.message
    ME.identifier
end
disp('report generated');
             

clear Copy_of_label_Check_v_0_0_2;
end





        
    



