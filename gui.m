function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 29-Nov-2021 05:47:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axesImage,'Visible','off');
set(handles.txtVacc,'Visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnBrowes.
function btnBrowes_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile({'*.*'},'Select file');
var = strcat(pathname,filename);

set(handles.axesImage,'Visible','on');
set(handles.txtVacc,'Visible','on');

handles.I = imread(var);
axes(handles.axesImage);
imshow(handles.I);
title('\color{white}Vaccination Card');

%----------------------------------------------------------------
%Read the card
handles.BW =im2bw(handles.I, 0.7);

%I = imread('sinopharm2.jpg');
%imtool(P);




%[m,n,l] = size(BW);
BW=handles.BW;
%A = BW(1:m,110:1500,:);
%rows_num(i)=sum(k2(i,:)); 
% find the minimummvalue of rows_num, decided the i(row number)
%imshow(A);


for row=180:400
    sum = 0;
    for col=250:650
        pixelValue = BW(row, col); % If it's a gray scale image.
        sum = sum + pixelValue;
        if(pixelValue ~= 0)
            continue;
        end
    end
    if(sum == 0)
        R1 = row; 
        break;
    end
end

a = R1+10;
for row=a:375
    sum = 0;
    for col=250:650
        pixelValue = BW(row, col); % If it's a gray scale image.
        sum = sum + pixelValue;
        if(pixelValue ~= 0)
            continue;
        end
        
    end
    if(sum == 0)
        R2 = row; 
        break;
    end
end

for col=250:650
    sum = 0;
    for row=R1:400
        pixelValue = BW(row, col); % If it's a gray scale image.
        sum = sum + pixelValue;
        if(pixelValue ~= 0)
            continue;
        end
        
    end
    if(sum == 0)
        C1 = col;  
        break;
    end
end

b = C1+10;
for col=b:650
    sum = 0;
    for row=R1:400
        pixelValue = BW(row, col); % If it's a gray scale image.
        sum = sum + pixelValue;
        if(pixelValue ~= 0)
            continue;
        end
       
    end
    if(sum == 0)
        C2 = col;  
        break;
    end
end

%fprintf('%d %d %d %d \n',R1,R2,C1,C2);

crop_image = BW(R1:R2,C1:C2);

%imshow(crop_image);

[m,n] = size(crop_image);

y=floor(m/2);


vacc_1 = crop_image(10:y-10,10:n-10);
%imshow(vacc_1);
vacc_2 = crop_image(y+10:m-10,10:n-10);
%imshow(vacc_2);

vacc_1 = ~vacc_1;
vacc_2 = ~vacc_2;

[L1, letters_1] = bwlabel(vacc_1,8);
%imshow(vacc_1);
%hold on;
% Trace the boundaries of the coins
%[B,L] = bwboundaries(vacc_1,'noholes');
%for i = 1:length(B)
 %   boundary = B{i};
 %   plot(boundary(:,2), boundary(:,1), 'blue', 'LineWidth', 3)
%end

[L2, letters_2] = bwlabel(vacc_2,8);
%imshow(vacc_2);
%hold on;
% Trace the boundaries of the coins
%[B,L] = bwboundaries(vacc_2,'noholes');
%for i = 1:length(B)
%   boundary = B{i};
 %   plot(boundary(:,2), boundary(:,1), 'blue', 'LineWidth', 3)
%end

fprintf('%d\n',letters_1);
if(letters_1 > 0)
    fprintf('Yes Dose 1\n');
    str = 'Yes Dose 1';
else
    printf('No Dose 1\n');
    str = 'No Dose 1';
end

fprintf('%d\n',letters_2);
if(letters_2 > 0)
    fprintf('Yes Dose 2\n');
    str = 'Yes Dose 2';
else
    fprintf('No Dose 2\n');
    str = 'No Dose 2';
end
set(handles.txtVacc, 'string', str);
guidata(hObject,handles);

function txtVacc_Callback(hObject, eventdata, handles)
% hObject    handle to txtVacc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtVacc as text
%        str2double(get(hObject,'String')) returns contents of txtVacc as a double






% --- Executes during object creation, after setting all properties.
function txtVacc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtVacc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
