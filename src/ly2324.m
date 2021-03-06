function varargout = ly2324(varargin)
% LY2324 MATLAB code for ly2324.fig
%      LY2324, by itself, creates a new LY2324 or raises the existing
%      singleton*.
%
%      H = LY2324 returns the handle to a new LY2324 or the handle to
%      the existing singleton*.
%
%      LY2324('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LY2324.M with the given input arguments.
%
%      LY2324('Property','Value',...) creates a new LY2324 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ly2324_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ly2324_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ly2324

% Last Modified by GUIDE v2.5 19-May-2015 04:09:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ly2324_OpeningFcn, ...
                   'gui_OutputFcn',  @ly2324_OutputFcn, ...
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


% --- Executes just before ly2324 is made visible.
function ly2324_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ly2324 (see VARARGIN)

% Choose default command line output for ly2324
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ly2324 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ly2324_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
global candidImageDir;
num = get(hObject, 'value');
content = get(handles.listbox2, 'string');

if (num > 0)
    index = content(num, :)
    dstImg = imread(fullfile(candidImageDir, [num2str(str2num(index)), '.jpg']));

    axes(handles.axes2);
    imshow(dstImg);
end

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global queryImagePath;
[filename, pathname] = uigetfile({ ...
    '*.*','All Files(*.*)';},...
    'Choose a file');
%
if isequal([filename, pathname], [0,0])
    return
else
    queryImagePath = fullfile(pathname, filename);
    srcImg = imread(queryImagePath);
    axes(handles.axes1);
    imshow(srcImg);
end



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% QuerybyImage
load AAA.mat
load 'data.mat'

global queryImagePath;
global candidImageDir;

srcImg = imread(queryImagePath);

resList = QuerybyImage( srcImg, Data, 17, AAA, 0 );

set(handles.listbox2, 'string', num2str(resList));

resImg = imread(fullfile(candidImageDir, [num2str(resList(1)), '.jpg']));
axes(handles.axes2);
imshow(resImg);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global candidImageDir;
candidImageDir = uigetdir;

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton4.
function pushbutton4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global candidImageDir
dirOutput = dir(fullfile(candidImageDir, '*.jpg'));
fileNames = {dirOutput.name}';
[height, width] = size(fileNames)
datasetup([candidImageDir, '/'], 1, height, 17);
