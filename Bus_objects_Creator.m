function BusfromBusCreator()
[MODEL,MODEL_Path] = uigetfile('*.slx','Select Model');
open_system(MODEL)
Model_Name=replace(MODEL,'.slx','');
businfo=Simulink.Bus.createObject(Model_Name,'BusTest/Bus_Creation/Bus Creator2');

end