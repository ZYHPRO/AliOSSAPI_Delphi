unit uDemoMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
    // ��ӵ�uses
  ALIOSS;
type
  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    cbOssHost: TEdit;
    TabSheet2: TTabSheet;
    Label8: TLabel;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    BucketE: TEdit;
    Button4: TButton;
    TabSheet3: TTabSheet;
    Label6: TLabel;
    Edit1: TEdit;
    Panel1: TPanel;
    Label9: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Memo2: TMemo;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button15: TButton;
    Button16: TButton;
    edOssAccessId: TComboBox;
    edOssAccessKey: TComboBox;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Btn1: TButton;
    ts1: TTabSheet;
    Btn2: TButton;
    Btn3: TButton;
    Edit2: TEdit;
    Btn4: TButton;
    procedure Btn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    function GetStreamString( stream:TStream ):string;
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
  Generics.Collections;
var
  ossfs: TAliOssFileSystem;
  volumns: TAliOssVolumnInfoList;
{$R *.dfm}

procedure TForm2.Btn1Click(Sender: TObject);
begin
  Button1.Click;
  Button5.Click;
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
if ossfs.CreateDirectory('zhyy')then
Label9.Caption:='Ŀ¼�����ɹ�' else
Label9.Caption:='Ŀ¼����ʧ��';
end;

procedure TForm2.Button11Click(Sender: TObject);
begin
if ossfs.RemoveDirectory('zhyy')then
Label9.Caption:='Ŀ¼ɾ���ɹ�' else
Label9.Caption:='Ŀ¼ɾ��ʧ��';
end;

procedure TForm2.Button12Click(Sender: TObject);
begin
if ossfs.RenameFile('zhy/zhy.txt','zhy/zhyup.txt')then
Label9.Caption:='�ļ������ĳɹ�' else
Label9.Caption:='�ļ�������ʧ��';
end;

procedure TForm2.Button13Click(Sender: TObject);
begin
if ossfs.RemoveFile( 'zhy/zhyup.txt')then
Label9.Caption:='�ļ�ɾ���ɹ�' else
Label9.Caption:='�ļ�ɾ��ʧ��';
end;

procedure TForm2.Button15Click(Sender: TObject);
 var
 permission: TAliOssVolumnPermission  ;
begin
 ossfs.GetVolumnPermission(BucketE.Text,permission) ;
 if permission=vPrivate then  Label9.Caption:='vPrivate';
 if permission=vPublicRead then  Label9.Caption:='vPublicRead';
 if permission=vPublicReadWrite then  Label9.Caption:='vPublicReadWrite';
end;

procedure TForm2.Button16Click(Sender: TObject);
 var
 permission: TAliOssVolumnPermission  ;
begin
 permission:=vPrivate;
 //��ǰbuket����Ч
if ossfs.SetVolumnPermission(BucketE.Text,permission) then
Label9.Caption:='bucketȨ�����óɹ�' else
Label9.Caption:='bucketȨ������ʧ��';
end;

procedure TForm2.Button17Click(Sender: TObject);
var
filepath:string;
content: TStream;
Size,Position:integer;
begin
filepath:=ExtractFilePath(Application.ExeName);
  ossfs.ReadFile( edit1.Text,content) ;
  Size:= content.Size;
  Position:= content.Position;
  Memo2.Clear;
  Memo2.Lines.Add('��Դ��С��' +inttostr(Size));
  content.Position:=0;
  Memo2.Lines.Add('��Դλ�ã�' +inttostr(Position));
  Memo2.Lines.Add('��Դ���ݣ�'+GetStreamString(content));

  //��
  //content.Position:=0;
  //memo2.Lines.LoadFromStream(content);
end;

procedure TForm2.Button18Click(Sender: TObject);
var
filepath:string;
content: TStream;
Size,Position:integer;
getStream,setStream: TFileStream; {����һ���ļ���}
getPath,setPath: string;
begin
 filepath:=ExtractFilePath(Application.ExeName);
  ossfs.ReadFile(edit1.Text,content) ;
  Size:= content.Size;
  Position:= content.Position;
  content.Position:=0;

  setPath := 'test.txt'; {������Զ�����}
  setStream := TFileStream.Create(setPath, fmCreate);
  setStream.CopyFrom(content, content.Size); {Copy ��}
  setStream.Free;



end;

procedure TForm2.Button19Click(Sender: TObject);
begin
ossfs.WriteFile('zhy/zhy111.txt', '���44444444', false) ;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
   try
    ossfs := TAliOssFileSystem.Create(self.edOssAccessId.Text, self.edOssAccessKey.Text, self.cbOssHost.Text);
    Label9.Caption:='��֤�ɹ�'
    except
    Label9.Caption:='��֤���ɹ�';
    end;
end;

procedure TForm2.Button20Click(Sender: TObject);
var
IStream : TStream;
begin
Istream :=TFileStream.Create('1.txt',fmOpenRead);
ossfs.WriteFile('zhy/zhy111.txt', Istream, false) ;
IStream.Free;
end;

procedure TForm2.Button21Click(Sender: TObject);
var
str:string;
begin
//ע��ֻ�� WriteFile(const filename, content: string; const append: boolean = false)����Ч
ossfs.readFile('zhy/zhy111.txt',str) ;
Memo2.Text:=str;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
 if ossfs.CreateVolumn(BucketE.Text) then
Label9.Caption:='bucket�����ɹ�' else
Label9.Caption:='bucket����ʧ��';
end;

procedure TForm2.Button3Click(Sender: TObject);

var
 i,c:integer;
begin
ossfs.ListVolumns(volumns);
memo1.Lines.Clear;
//�о�Bucket
for i:=low(volumns) to high(volumns) do
memo1.Lines.Add( volumns[i].name);
end;

procedure TForm2.Button4Click(Sender: TObject);
begin

ossfs.RemoveVolumn(BucketE.Text,false);
Label9.Caption:='bucketɾ���ɹ�';

end;

procedure TForm2.Button5Click(Sender: TObject);
var
  bucket: string;
begin
//  bucket :=  'pm-hangye-test';
  bucket :=  'pmdown';
if ossfs.ChangeVolumn(bucket) then
Label9.Caption:='bucket='+ bucket else
Label9.Caption:='bucket>'+bucket;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
 if ossfs.FileExists(edit1.Text) then
Label9.Caption:='�ļ�����' else
Label9.Caption:='�ļ�������';

end;

procedure TForm2.Button7Click(Sender: TObject);
var
files: TAliOssFileInfoList;
c,i:integer;
directory:string;
begin
Memo2.Clear;
directory:=''; //�ڵ�ǰbuket���������ļ� directory='allresourse'
ossfs.ListDirectory('',files,false);
for i:=low(files) to high(files) do
memo2.Lines.Add( files[i].name);
end;

procedure TForm2.Button8Click(Sender: TObject);
var
filepath:string;
begin
filepath:=ExtractFilePath(Application.ExeName);
 if ossfs.DownloadFile(edit1.Text,filepath+'zhy����.txt') then
Label9.Caption:='�ļ����سɹ�' else
Label9.Caption:='�ļ�����ʧ��';

end;

procedure TForm2.Button9Click(Sender: TObject);
var
filepath:string;
begin
filepath:=ExtractFilePath(Application.ExeName);
 if ossfs.UploadFile( filepath+'zhy.txt','zhy/zhy.txt') then
Label9.Caption:='�ļ��ϴ��ɹ�' else
Label9.Caption:='�ļ��ϴ�ʧ��';

end;

function TForm2.GetStreamString(stream: TStream): string;

var
strStream:TStringStream;
begin
strStream:= TStringStream.Create( ' ' );
try
strStream.CopyFrom( stream, stream.Size );
Result:=strStream.DataString;
finally
strStream.Free;
end;
end;

end.
