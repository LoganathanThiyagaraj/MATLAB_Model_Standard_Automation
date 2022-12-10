
[MODEL_NAME,MODEL_Path] = uigetfile('*.slx','Select Model');

open_system(MODEL_NAME)
Model_Name=replace(MODEL_NAME,'.slx','');
All_Constants	 = find_system(Model_Name,'BlockType','Constant');
All_Constants_Names  = get_param(All_Constants, 'Name');
All_Constants_Values  = get_param(All_Constants, 'Value');
All_Constants_Backgroundcolor  = get_param(All_Constants, 'BackgroundColor');
k=1;
for ii=1:length(All_Constants_Backgroundcolor) 
  if strcmp(All_Constants_Backgroundcolor(ii),'lightBlue')
      BC_constants(k)=All_Constants(ii);
      BC_constants_Names(k)=All_Constants_Names(ii);
      BC_constants_Values(k)=All_Constants_Values(ii);
      k=k+1;
  end
end
 BC_constants=transpose(BC_constants);  
 BC_constants_Names=transpose(BC_constants_Names);
 BC_constants_Values=transpose(BC_constants_Values);
 
 A = {'Constant Path','Constant Names', 'Constant Values'};
e = actxserver('Excel.Application');
eWorkbook = e.Workbooks.Add;
e.Visible = 1;
eSheets = e.ActiveWorkbook.Sheets;
eSheet1 = eSheets.get('Item',1);
eSheet1.Activate
eActiveSheet = get(e, 'ActiveSheet');
eSheet1.Range('A1:C1').Value=A;
siz=size(BC_constants);
siz=siz(1)+1;

for i=2:siz(1)
    E=string(BC_constants{i-1});
    F=string(BC_constants_Names{i-1});
    G=string(BC_constants_Values{i-1});
ch=['A2:A' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = BC_constants;
    
ch=['B2:B' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = BC_constants_Names;

ch=['C2:C' num2str((siz))];
eActivesheetRange = get(e.Activesheet,'Range',ch);
eActivesheetRange.Value = BC_constants_Values;
end

filename=[pwd '\' Model_Name '_Tunable_Constant_BlueBG.xlsx'];

[file,path]=uiputfile(filename);
eWorkbook.SaveAs(fullfile(path,file));