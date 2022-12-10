clear all
clc

[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');

open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');

All_Constants	 = find_system(Model_Name,'BlockType','Constant');
All_Constants_Names  = get_param(All_Constants, 'Name');
All_Constants_Values  = get_param(All_Constants, 'Value');
All_Constants_Datatype  = get_param(All_Constants, 'OutDataTypeStr');

% All_Constants=transpose(All_Constants);
% All_Constants_Names=transpose(All_Constants_Names);
% All_Constants_Values=transpose(All_Constants_Values);
% All_Constants_Datatype=transpose(All_Constants_Datatype);
x='''';

All_Gains	 = find_system(Model_Name,'BlockType','Gain');
All_Gain_Names  = get_param(All_Gains, 'Name');
All_Gain_Values  = get_param(All_Gains, 'Gain');
All_Gain_Values = strcat(x,All_Gain_Values );
All_Gain_Datatype  = get_param(All_Gains, 'OutDataTypeStr');


% All_Gains=transpose(All_Gains);
% All_Gain_Names=transpose(All_Gain_Names);
% All_Gain_Values=transpose(All_Gain_Values);
% All_Gain_Datatype=transpose(All_Gain_Datatype);
All_Blocks={};
 All_Blocks = find_system(Model_Name,'MaskType','Compare To Constant');
k=1;

All_CTC={};
All_CTC_Names={};
All_CTC_Values={};
All_CTC_Datatype={};
 for i=1:length(All_Blocks)
   
        All_CTC{k,1}= All_Blocks{i};
        All_CTC_Names{k,1} = get_param(All_CTC{k,1}, 'Name');
        All_CTC_Values{k,1}  = get_param(All_CTC{k,1},'const');
        All_CTC_Values{k,1}= strcat(x,All_CTC_Values{k,1} );
        All_CTC_Datatype{k,1}  = get_param(All_CTC{k,1}, 'OutDataTypeStr');
        k=k+1;
     
 end
% All_CTC=(transpose(All_CTC)) ;
% All_CTC_Names=(transpose(All_CTC_Names));
% All_CTC_Values=(transpose(All_CTC_Values)) ;
% All_CTC_Datatype=(transpose(All_CTC_Datatype)) ;
 
kkt=1 ;
kk=1;
mm=1;
mmt=1;
All_1_D_Lookup={};
All_1_D_Lookup_Name={};
All_1_D_Lookup_Tab_Data={};
All_1_D_Lookup_Tab_InputValues={};
All_1_D_Lookup_Type2={};
All_1_D_Lookup_Name_Type2={};
All_1_D_Lookup_Tab_Data_Type2={};
All_1_D_Lookup_Tab_Type_Type2={};  
All_1_D_Lookup_Tab_Dim1_Type2={};  

All_Blck	 = find_system(Model_Name,'Type','Block');
for i=1:length(All_Blck)
    str=get_param(All_Blck(i),'BlockType');
     if strcmp(str,'Lookup')
      All_1_D_Lookup(kk,1)=All_Blck(i);
      All_1_D_Lookup_Name(kk,1)=get_param(All_Blck(i), 'Name');
      All_1_D_Lookup_Tab_Data(kk,1)=get_param(All_Blck(i), 'Table');
      All_1_D_Lookup_Tab_InputValues(kk,1)=get_param(All_Blck(i), 'InputValues');  
      kk=kk+1;
     end
     if strcmp(str,'Lookup_n-D') 
         Dim=get_param(All_Blck(i),'NumberOfTableDimensions');
         if strcmp(Dim,'1') 
      All_1_D_Lookup_Type2(kkt,1)=All_Blck(i);
      All_1_D_Lookup_Name_Type2(kkt,1)=get_param(All_Blck(i), 'Name');
      All_1_D_Lookup_Tab_Data_Type2(kkt,1)=get_param(All_Blck(i), 'Table');
      All_1_D_Lookup_Tab_Type_Type2(kkt,1)=get_param(All_Blck(i), 'TableDataTypeStr');  
      All_1_D_Lookup_Tab_Dim1_Type2(kkt,1)=get_param(All_Blck(i), 'BreakpointsForDimension1');  
      kkt=kkt+1;
         end
     end
end



All_2_D_Lookup = {};
All_2_D_Lookup_Name = {};
All_2_D_Lookup_Tab_Data = {};
All_2_D_Lookup_Tab_RowIndex = {};
All_2_D_Lookup_Tab_ColumnIndex = {};

All_2_D_Lookup_Type2={};
All_2_D_Lookup_Name_Type2={};
All_2_D_Lookup_Tab_Data_Type2={};
All_2_D_Lookup_Tab_Type_Type2={};  
All_2_D_Lookup_Tab_Dim1_Type2={};  
All_2_D_Lookup_Tab_Dim2_Type2={};

for i=1:length(All_Blck)
    str=get_param(All_Blck(i),'BlockType');
    
     if strcmp(str,'Lookup2D')       
         All_2_D_Lookup(mm,1)=All_Blck(i);
         All_2_D_Lookup_Name(mm,1)=get_param(All_Blck(i), 'Name');
         All_2_D_Lookup_Tab_Data(mm,1)=get_param(All_Blck(i), 'Table');
         All_2_D_Lookup_Tab_RowIndex(mm,1)=get_param(All_Blck(i), 'RowIndex');  
         All_2_D_Lookup_Tab_ColumnIndex(mm,1)=get_param(All_Blck(i), 'ColumnIndex');  
         
         mm=mm+1;
     end
     
      if strcmp(str,'Lookup_n-D') 
           Dim=get_param(All_Blck(i),'NumberOfTableDimensions');
           if strcmp(Dim,'2') 
         All_2_D_Lookup_Type2(mmt,1)=All_Blck(i);
         All_2_D_Lookup_Name_Type2(mmt,1)=get_param(All_Blck(i), 'Name');
         All_2_D_Lookup_Tab_Data_Type2(mmt,1)=get_param(All_Blck(i), 'Table');
         All_2_D_Lookup_Tab_Type_Type2(mmt,1)=get_param(All_Blck(i), 'TableDataTypeStr');  
         All_2_D_Lookup_Tab_Dim1_Type2(mmt,1)=get_param(All_Blck(i), 'BreakpointsForDimension1');  
         All_2_D_Lookup_Tab_Dim2_Type2(mmt,1)=get_param(All_Blck(i), 'BreakpointsForDimension2');  
         mmt=mmt+1;
           end
     end
end
     



All_Blocks_ = find_system(Model_Name,'Type','Block');
k=1;
 for i=1:length(All_Blocks_)
     Lookup_type_blocks=get_param(All_Blocks_(i), 'Type');
     k=k+1;
 end
k=1;
All_Slider = {};
All_Slider_Names= {};
All_Slider_Values= {};
 for i=1:length(All_Blocks_)
     if contains(All_Blocks_(i),'/Slider')
All_Slider(k,1)=All_Blocks_(i);
All_Slider_Names(k,1)  = get_param(All_Blocks_(i), 'Name');
All_Slider_Values(k,1)  = get_param(All_Blocks_(i), 'Gain');
k=k+1;
     end
 end
%  All_Slider=transpose(All_Slider);
%  All_Slider_Names=transpose(All_Slider_Names);
%  All_Slider_Values=transpose(All_Slider_Values);
%  
 
e = actxserver('Excel.Application');
eWorkbook = e.Workbooks.Add;
eShet = e.Sheets.Add;
eShet = e.Sheets.Add;
eShet = e.Sheets.Add;
eShet = e.Sheets.Add;
eShet = e.Sheets.Add;
eShet = e.Sheets.Add;
eShet = e.Sheets.Add;
e.Visible = 1;
eSheets = e.ActiveWorkbook.Sheets;
eSheet1 = eSheets.get('Item',1);
eSheet2 = eSheets.get('Item',2);
eSheet3 = eSheets.get('Item',3);
eSheet4 = eSheets.get('Item',4);
eSheet5 = eSheets.get('Item',5);
eSheet6 = eSheets.get('Item',6);
eSheet7 = eSheets.get('Item',7);
eSheet8 = eSheets.get('Item',8);

%-----------------------constant---------------------
eSheet1.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Constant Path','Constant Name', 'Constant Value','Constant Datatype'};
eSheet1.Range('A1:D1').Value=A;
siz=size(All_Constants);
siz=siz(1)+1;

for i=2:siz(1)
   
ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Constants;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Constants_Names;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Constants_Values;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Constants_Datatype;
end
% %-----------------------Gain---------------------
eSheet2.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Gain Path','Gain Name', 'Gain Value','Gain Datatype'};
eSheet2.Range('A1:D1').Value=A;
siz=size(All_Gains);
siz=siz(1)+1;

for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Gains;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Gain_Names;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Gain_Values;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Gain_Datatype;
end



%-----------------------CTC---------------------
eSheet3.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'CTC Path','CTC Name', 'CTC Value','CTC Datatype'};
eSheet3.Range('A1:D1').Value=A;
siz=size(All_CTC);
siz=siz(1)+1;

for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_CTC;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_CTC_Names;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_CTC_Values;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_CTC_Datatype;
end


%-----------------------Loopup_1D---------------------

eSheet4.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Lookup_1-D Path','Lookup_1-D Names', 'Lookup_1-D Table Data','Lookup_1-D Input Values'};
eSheet4.Range('A1:D1').Value=A;
siz=size(All_1_D_Lookup);
siz=siz(1)+1;

for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Name;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Tab_Data;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Tab_InputValues;


end

%-----------------------Loopup_2D---------------------

      
      

eSheet5.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Lookup_1-D Path','Lookup_2-D Names', 'Lookup_2-D Table Data','Lookup_2-D RowIndex','Lookup_2-D ColumnIndex'};
eSheet5.Range('A1:E1').Value=A;
siz=size(All_2_D_Lookup);
siz=siz(1)+1;

for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Name;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_Data;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_RowIndex;

ch=['E2:E' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_ColumnIndex;


end


%-----------------------Slider Gain---------------------
   

eSheet6.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Slider Gain Path','Slider Gain Name', 'Slider Gain Value'};
eSheet6.Range('A1:C1').Value=A;
siz=size(All_Slider);
siz=siz(1)+1;

for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Slider;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Slider_Names;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_Slider_Values;



end

%-----------------------Loopup_1D Type2---------------------

eSheet7.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Lookup_1-D Path','Lookup_1-D Names', 'Lookup_1-D Table Data','Lookup_1-D BreakpointsForDimension1','Lookup_1-D Datatype'};
eSheet7.Range('A1:E1').Value=A;
siz=size(All_1_D_Lookup_Type2);
siz=siz(1)+1;

for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Type2;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Name_Type2;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Tab_Data_Type2;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Tab_Dim1_Type2;

ch=['E2:E' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_1_D_Lookup_Tab_Type_Type2;
end

%-----------------------Loopup_2D Type2---------------------

      
      

eSheet8.Activate
eActiveSheet = get(e, 'ActiveSheet');
A = {'Lookup_1-D Path','Lookup_2-D Names', 'Lookup_2-D Table Data','Lookup_2-D BreakpointsForDimension1','Lookup_2-D BreakpointsForDimension2','Lookup_2-D Datatype'};
eSheet8.Range('A1:F1').Value=A;
siz=size(All_2_D_Lookup_Type2);
siz=siz(1)+1;


for i=2:siz(1)

ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Type2;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Name_Type2;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_Data_Type2;

ch=['D2:D' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_Dim1_Type2;

ch=['E2:E' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_Dim2_Type2;

ch=['F2:F' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = All_2_D_Lookup_Tab_Type_Type2;
end


eSheet1.Name='Constants';
eSheet2.Name='Gains';
eSheet3.Name='Compare_To_Constants';
eSheet4.Name='Type1-Lookup_1D';
eSheet5.Name='Type1-Lookup_2D';
eSheet6.Name='Slider Gain';
eSheet7.Name='Type2-Lookup_1D';
eSheet8.Name='Type2-Lookup_2D';
filename=[pwd '\' Model_Name '_Constants_Values.xlsx'];

[file,path]=uiputfile(filename);
eWorkbook.SaveAs(fullfile(path,file));


