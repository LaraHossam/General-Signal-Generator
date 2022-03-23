function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 28-Dec-2021 15:00:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

assignin('base', 'flag', 0);
assignin('base', 'flagModification', 0);


% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popUpMenu.
function popUpMenu_Callback(hObject, eventdata, handles)
% hObject    handle to popUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popUpMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popUpMenu


% --- Executes during object creation, after setting all properties.
function popUpMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popUpMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exitButton.
function exitButton_Callback(hObject, eventdata, handles)
% hObject    handle to exitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in performOpButton.
function performOpButton_Callback(hObject, eventdata, handles)
% hObject    handle to performOpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

operationChoice = get(handles.popUpMenu, 'Value');
value = str2double(get(handles.valueText, 'String'));

flag = evalin('base','flag');
flagModification = evalin('base','flagModification');
if flag == 0
    errordlg('Please generate a signal to modify', 'Invalid Function');
    return
end

if isnan(value) && operationChoice ~= 2
    errordlg('Please specify an integer as Value','Invalid Input');
    return
end

if flagModification == 0
    signal = evalin('base','signal');
    t = evalin('base','t');
    set(handles.generatedSignalText, 'String', 'Previous Signal');
    set(handles.modifiedSignalText, 'String', 'Modified Signal');
else
    prompt = {['Which signal do you want to modify?' sprintf('\n') '1. Previous Signal' sprintf('\n') '2. Original Signal']};
    dlgtitle = 'Signal to Modify';
    dims = [1 50];
    definput = {''};
    choice = str2double(inputdlg(prompt, dlgtitle, dims, definput));
    
    %Error Handling to avoid invalid negative inputs or non numeric values.
    while choice ~= 1 && choice ~= 2
        prompt = {['Try Again, enter a valid option.' sprintf('\n') '1. Previous Signal' sprintf('\n') '2. Original Signal']};
        dlgtitle = 'Invalid Input!';
        dims = [1 50];
        definput = {'1'};
        choice = str2double(inputdlg(prompt, dlgtitle, dims, definput));
    end
    
    if choice == 1
        signal = evalin('base','signal');
        t = evalin('base','t');
        set(handles.generatedSignalText, 'String', 'Previous Signal');
        set(handles.modifiedSignalText, 'String', 'Modified Signal');
    else
        signal = evalin('base','oldSignal');
        t = evalin('base','oldInterval');
        set(handles.generatedSignalText, 'String', 'Original Signal');
        set(handles.modifiedSignalText, 'String', 'Modified Signal');
    end
end

oldSignal = signal;
modifiedSignal = oldSignal;
oldInterval = t;
newInterval = oldInterval;
     
switch operationChoice
    case 1 %Amplitude Scaling
        scaleValue = value;
        modifiedSignal = oldSignal*scaleValue;
        
    case 2 %Time Reversal
        newInterval = oldInterval*-1;
    case 3 %Time Shift
        shiftValue = value;
        newInterval = oldInterval - shiftValue;
    case 4 %Expanding the signal
        expandingValue = value;
        newInterval = oldInterval*expandingValue;
    case 5 %Compressing the signal
        compressingValue = value;
        if compressingValue == 0
            errordlg('Not possible to divide by 0.','Mathematical Error');
            return
        end 
        newInterval = oldInterval/compressingValue;
end

plot(handles.axes1, oldInterval, oldSignal(1:length(oldInterval)), 'blue', 'linewidth', 2)
grid(handles.axes1, 'on')
grid(handles.axes1,'minor')

plot(handles.axes2, newInterval, modifiedSignal(1:length(newInterval)), 'red', 'linewidth', 2)
grid(handles.axes2, 'on')
grid(handles.axes2,'minor')




assignin('base', 'signal', modifiedSignal);
assignin('base', 't', newInterval);

if flagModification == 0
    assignin('base', 'oldSignal', oldSignal);
    assignin('base', 'oldInterval', oldInterval);

    assignin('base', 'flagModification', 1);
end




% --- Executes during object creation, after setting all properties.
function valueText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valueText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'Enter the sampling frequency: '};
dlgtitle = 'Sampling Frequency';
dims = [1 50];
definput = {''};
samplingFreq = str2double(inputdlg(prompt, dlgtitle, dims, definput));

%Error Handling to avoid invalid negative inputs or non numeric values.
while (samplingFreq<=0) || isnan(samplingFreq)
    prompt = {['Try Again, enter a valid positive number.' sprintf('\n') 'Enter the sampling frequency: ' sprintf('\n')]};
    dlgtitle = 'Invalid Input!';
    dims = [1 50];
    definput = {'20','hsv'};
    samplingFreq = str2double(inputdlg(prompt,dlgtitle,dims,definput));
end

prompt = {'Enter the starting time:', 'Enter the ending time:'};
dlgtitle = 'Time';
dims = [1 50];
definput = {'',''};
time = inputdlg(prompt,dlgtitle,dims,definput);
startTime = str2double(time(1));
endTime = str2double(time(2));

%Error Handling to avoid non numeric values.
while isnan(startTime)
    prompt = {['Try Again, time must be a number.' sprintf('\n') 'Enter the starting time: ']};
    dlgtitle = 'Invalid Input!';
    dims = [1 50];
    definput = {'-5'};
    startTime = str2double(inputdlg(prompt,dlgtitle,dims,definput));
end

%Error Handling to avoid non numeric values.
while isnan(endTime)
    prompt = {['Try Again, time must be a number.' sprintf('\n') 'Enter the ending time: ']};
    dlgtitle = 'Invalid Input!';
    dims = [1 50];
    definput = {'5'};
    endTime = str2double(inputdlg(prompt,dlgtitle,dims,definput));
end 
%     %Error Handling to avoid illogical times.
while (startTime>=endTime)
prompt = {'Try Again, Start time must be < End Time. Enter the starting time:', 'Enter the ending time:'};
dlgtitle = 'Time';
dims = [1 50];
definput = {'',''};
time = inputdlg(prompt,dlgtitle,dims,definput);
startTime = str2double(time(1));
endTime = str2double(time(2));

    %Error Handling to avoid non numeric values.
    while isnan(startTime)
        prompt = {['Try Again, time must be a number.' sprintf('\n') 'Enter the starting time: ']};
        dlgtitle = 'Invalid Input!';
        dims = [1 50];
        definput = {'-5'};
        startTime = str2double(inputdlg(prompt,dlgtitle,dims,definput));
    end

    %Error Handling to avoid non numeric values.
    while isnan(endTime)
        prompt = {['Try Again, time must be a number.' sprintf('\n') 'Enter the ending time: ']};
        dlgtitle = 'Invalid Input!';
        dims = [1 50];
        definput = {'5'};
        endTime = str2double(inputdlg(prompt,dlgtitle,dims,definput));
    end
end

prompt = {['Enter the number of break points: ']};
dlgtitle = 'Sampling Frequency';
dims = [1 50];
definput = {''};
numberBreakPoints = str2double(inputdlg(prompt,dlgtitle,dims,definput));

%Error Handling to avoid non numeric values.
while isnan(numberBreakPoints) 
    prompt = {['Try Again, enter a number.' sprintf('\n') 'Enter the number of break points: ']};
    dlgtitle = 'Invalid Input';
    dims = [1 50];
    definput = {'1'};
    numberBreakPoints = str2double(inputdlg(prompt,dlgtitle,dims,definput));
end

breakPoints = zeros(1, numberBreakPoints);

%Prompting user to define the exact positions of breakpoints, and
%setting time axis values and number of samples
if numberBreakPoints == 0 
    t = linspace(startTime, endTime, (endTime-startTime)*samplingFreq);
else
    for i=0:numberBreakPoints-1
        prompt = {['Break Point number ' num2str(i+1) ' at t = ']};
        dlgtitle = 'Break Point';
        dims = [1 50];
        definput = {'0'};
        breakPoints(i+1) = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        while isnan(breakPoints(i+1)) || breakPoints(i+1)<startTime ||breakPoints(i+1) >endTime
            prompt = {['Try again.' sprintf('\n') 'Break Point number ' num2str(i+1) ' at t = ']};
            dlgtitle = 'Invalid Range or Format';
            dims = [1 50];
            definput = {'0'};
            breakPoints(i+1) = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        end
        if i > 0
            while breakPoints(i+1) <= breakPoints(i) || breakPoints(i+1) >= endTime || breakPoints(i+1) <= startTime
                prompt = {['Try again.' sprintf('\n') 'Break Point number ' num2str(i+1) ' at t = ']};
                dlgtitle = 'Please enter breakpoints in chronological order. ';
                dims = [1 50];
                definput = {'0'};
                breakPoints(i+1) = str2double(inputdlg(prompt,dlgtitle,dims,definput));
            end
        end
    end
         
    t = linspace(startTime, breakPoints(1), (breakPoints(1)-startTime)*samplingFreq);
    %First range of t that will be used before the first breakpoint to
    %draw the initial signal
end

assignin('base', 'samplingFreq', samplingFreq);
assignin('base', 'startTime', startTime);
assignin('base', 'endTime', endTime);
assignin('base', 'numberBreakPoints', numberBreakPoints);
assignin('base', 't', t);
assignin('base', 'breakPoints', breakPoints);

set(handles.sampleValue, 'String', samplingFreq);
set(handles.startValue, 'String', startTime);
set(handles.endValue, 'String', endTime);
set(handles.breakValue, 'String', numberBreakPoints);


% --- Executes on button press in selectFunctionButton.
function selectFunctionButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectFunctionButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%choice from a list of signals and plotting it.
signal = [];   %vector of the signal that will be plotted

samplingFreq = evalin('base','samplingFreq');
startTime = evalin('base','startTime');
endTime = evalin('base','endTime');
t = evalin('base','t');
numberBreakPoints = evalin('base','numberBreakPoints');
breakPoints = evalin('base','breakPoints');

for i=1:numberBreakPoints+1
    if numberBreakPoints == 0
        prompt = {['Choose the specifications of the signal: ' sprintf('\n') '1)   DC Signal' sprintf('\n') '2)   Ramp signal' sprintf('\n') '3)   General order polynomial' sprintf('\n') '4)   Exponential signal' sprintf('\n') '5)   Sinusoidal signal']};
        dlgtitle = 'Input Specifications';
        dims = [1 50];
        definput = {'1'};
        choice = str2double(inputdlg(prompt,dlgtitle,dims,definput));
    elseif numberBreakPoints>0
        prompt = {['Choose the specifications of the signal before breakpoint number ' num2str(i) ':' sprintf('\n') '1)   DC Signal' sprintf('\n') '2)   Ramp signal' sprintf('\n') '3)   General order polynomial' sprintf('\n') '4)   Exponential signal' sprintf('\n') '5)   Sinusoidal signal']};
        dlgtitle = 'Input Specifications';
        dims = [1 50];
        definput = {'1'};
        choice = str2double(inputdlg(prompt,dlgtitle,dims,definput));
    end
    
    %Error Handling to avoid invalid inputs or non numeric values.
    while choice<1 || choice>5 || isnan(choice)
        prompt = {['Try Again, enter a valid positive number between 1 and 5' sprintf('\n')]};
        dlgtitle = 'Input Invalid';
        dims = [1 50];
        definput = {'1'};
        choice = str2double(inputdlg(prompt,dlgtitle,dims,definput));
    end
 
    switch choice
 
    case 1      %DC signal
        prompt = {['Enter the DC signal''s amplitude: ' sprintf('\n')]};
        dlgtitle = 'DC Signal';
        dims = [1 50];
        definput = {'0'};
        amplitudeDC = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        
        f(1:length(t))= amplitudeDC; 

    case 2      %Ramp signal
        prompt = {['Enter the Ramps signal''s slope: ' sprintf('\n')], ['Enter the Ramps signal''s intercept: ' sprintf('\n')]};
        dlgtitle = 'Ramp Signal';
        dims = [1 50];
        definput = {'0', '0'};
        array = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        
        slope = array(1);
        intercept = array(2);
                
        f  = (slope.*(t))+ intercept;

    case 3      %General Order Polynomial
        prompt = {['Enter the General Order Polynomial''s power: ' sprintf('\n')]};
        dlgtitle = 'General Order Polynomial';
        dims = [1 50];
        definput = {'0'};
        power = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        
        amplitudepolynomial = zeros(1, power+1);
        y = 1;
        
        for x=power:-1:1
            prompt = {['Enter the t^' num2str(x) ' coefficient:' sprintf('\n')]};
            dlgtitle = 'General Order Polynomial';
            dims = [1 50];
            definput = {'0'};
            amplitudepolynomial(y) = str2double(inputdlg(prompt,dlgtitle,dims,definput));
            
            y = y+1;
        end
        
        prompt = {['Enter the General Order Polynomial''s intercept: ' sprintf('\n')]};
        dlgtitle = 'General Order Polynomial';
        dims = [1 50];
        definput = {'1'};
        intercept = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        
        amplitudepolynomial(power+1) = intercept;
        f = polyval(amplitudepolynomial, t);

    case 4          %Exponential signal
        prompt = {['Enter the Exponential signal''s amplitude: ' sprintf('\n')], ['Enter the Exponential signal''s exponent: ' sprintf('\n')]};
        dlgtitle = 'Exponential Signal';
        dims = [1 50];
        definput = {'0', '0'};
        array = str2double(inputdlg(prompt,dlgtitle,dims,definput));
        amplitudeExponential = array(1);
        exponent = array(2);
        
        f  = amplitudeExponential*exp(exponent.*t);

    case 5          %Sinusoidal signal
        prompt = {['Enter the Sinusoidal signal''s amplitude: '],['Enter the Sinusoidal signal''s frequency: '], ['Enter the Sinusoidal signal''s phase: ']};
        dlgtitle = 'Sinusoidal Signal';
        dims = [1 50];
        definput = {'0', '0', '0'};
        array = str2double(inputdlg(prompt,dlgtitle,dims,definput));
                
        amplitudeSinusoidal = array(1);
        frequency = array(2);
        phase = array(3);
        
        f = amplitudeSinusoidal*sin(2*pi*frequency.*t + phase);
    end

    %Setting time vector for next portions of the signal 

    if i+1 <= numberBreakPoints  %end of the signal not reached yet
        t = linspace(breakPoints(i), breakPoints(i+1), (breakPoints(i+1)-breakPoints(i))*samplingFreq);

    elseif i == numberBreakPoints  %end of the signal reached
        t = linspace(breakPoints(i), endTime, ((endTime)-breakPoints(i))*samplingFreq);

    end
    signal = [signal f];
end
t = linspace(startTime, endTime, (endTime-startTime)*samplingFreq);

set(handles.generatedSignalText, 'String', 'Generated Signal');
set(handles.modifiedSignalText, 'String', ' ');

assignin('base', 'signal', signal);
assignin('base', 'flag', 1);
assignin('base', 't', t);

plot(handles.axes1, t, signal(1:length(t)), 'linewidth', 2)
grid(handles.axes1, 'on')
grid(handles.axes1,'minor')


function valueText_Callback(hObject, eventdata, handles)
% hObject    handle to valueText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of valueText as text
%        str2double(get(hObject,'String')) returns contents of valueText as a double
