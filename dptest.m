function varargout = dptest(varargin)
% DPTEST M-file for dptest.fig
%      DPTEST, by itself, creates a new DPTEST or raises the existing
%      singleton*.
%
%      H = DPTEST returns the handle to a new DPTEST or the handle to
%      the existing singleton*.
%
%      DPTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DPTEST.M with the given input arguments.
%
%      DPTEST('Property','Value',...) creates a new DPTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dptest_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dptest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dptest

% Last Modified by GUIDE v2.5 04-Feb-2004 22:03:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dptest_OpeningFcn, ...
                   'gui_OutputFcn',  @dptest_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before dptest is made visible.
function dptest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dptest (see VARARGIN)

% Choose default command line output for dptest
handles.output = hObject;


%init data
%time to record
handles.time = (1.5);

%create matrices
handles.X = zeros(1,1);
handles.Y = handles.X;

%create DP ctructure
handles.DP.dist = 0;
handles.DP.M = zeros(1,1);
handles.DP.D = zeros(1,1);

%set colormap
colormap(bone);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dptest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dptest_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in recordY.
function recordY_Callback(hObject, eventdata, handles)
% hObject    handle to recordY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Y = recordMelMatrix(handles.time);
guidata(hObject, handles);
plotData(handles);

% --- Executes on button press in recordX.
function recordX_Callback(hObject, eventdata, handles)
% hObject    handle to recordX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.X = recordMelMatrix(handles.time);
guidata(hObject, handles);
plotData(handles);


% --- Executes on button press in runDP.
function runDP_Callback(hObject, eventdata, handles)
% hObject    handle to runDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.DP = dp_asym(handles.X,handles.Y);
guidata(hObject, handles);
plotData(handles);

function plotData (handles)
%plot X
axes(handles.XSpec);
imagesc(flipud(handles.X));

%plot Y
axes(handles.YSpec);
imagesc(flipud(fliplr((handles.Y)')));

%plot DPPath
axes(handles.DPWin);
imagesc(flipud(handles.DP.M));



set (handles.distance,'String',handles.DP.dist);


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in colorbutton.
function colorbutton_Callback(hObject, eventdata, handles)
% hObject    handle to colorbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of colorbutton
colorState = get(hObject,'Value')
if (colorState == get(hObject,'Max'))
    colormap(jet);        
else
    colormap(bone);    
end


