function varargout = abhispeechrecognition(varargin)
% ABHISPEECHRECOGNITION MATLAB code for abhispeechrecognition.fig
%      ABHISPEECHRECOGNITION, by itself, creates a new ABHISPEECHRECOGNITION or raises the existing
%      singleton*.
%
%      H = ABHISPEECHRECOGNITION returns the handle to a new ABHISPEECHRECOGNITION or the handle to
%      the existing singleton*.
%
%      ABHISPEECHRECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABHISPEECHRECOGNITION.M with the given input arguments.
%
%      ABHISPEECHRECOGNITION('Property','Value',...) creates a new ABHISPEECHRECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abhispeechrecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abhispeechrecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abhispeechrecognition

% Last Modified by GUIDE v2.5 27-Sep-2013 15:15:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abhispeechrecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @abhispeechrecognition_OutputFcn, ...
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


% --- Executes just before abhispeechrecognition is made visible.
function abhispeechrecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abhispeechrecognition (see VARARGIN)


% Choose default command line output for abhispeechrecognition
handles.output = hObject;
handles.time = 1.5;

handles.X = zeros(1,1);

colormap(bone);
% Update handles structure
guidata(hObject, handles);
%init params


% UIWAIT makes abhispeechrecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = abhispeechrecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.X,handles.data] = abhisprogram(handles.time);
guidata(hObject, handles);
plotData(handles);
check(rectest(recordabhiMelMatrix(handles.data.s)));


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wavplay(handles.data.s,handles.data.fs);
function plotData(handles)
axes(handles.axes1);
imagesc(flipud(handles.X));
