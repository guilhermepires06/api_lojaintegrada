 {


                              A API possui os seguintes limites de requisições:
                              por aplicação (chave_aplicacao) - 3000 requisições / minuto (Err 533)
                              por loja (chave_api) - 100 requisições / minuto (Err 633)
                              por ip - 1200 requisições / minuto (Err 133)

                          *****Ao exceder o limite, a API retornará status 429 e o erro específico.****

                          Documentação:
                          https://api-docs.lojaintegrada.com.br/#cc3aca98-61cc-4471-a4fd-1dbacad3ca26

 }


















unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent,  System.JSON,
  System.Types, System.UITypes,  Vcl.ComCtrls, System.RegularExpressions,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type

  TForm1 = class(TForm)

    Memo1: TMemo;
    MemoResposta: TMemo;
    BTListarProd: TButton;
    NetHTTPClient1: TNetHTTPClient;
    BTEstoque: TButton;
    EditNome: TEdit;
    Button3: TButton;
    Label1: TLabel;
    PageControl1: TPageControl;
    VerificarProdutos: TTabSheet;
    CadastrarProdutos: TTabSheet;
    EditSku: TEdit;
    Label2: TLabel;
    EditNcm: TEdit;
    Label3: TLabel;
    BTValorProd: TButton;
    AlterarProdutos: TTabSheet;
    EditIDProd: TEdit;
    BTAlterarValor: TButton;
    Label5: TLabel;
    EditValorCheio: TEdit;
    Label6: TLabel;
    NetHTTPRequest1: TNetHTTPRequest;
    EditValorCusto: TEdit;
    EditValorPromocional: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Configuracao: TTabSheet;
    EditChave: TEdit;
    EditSenha: TEdit;
    Label4: TLabel;
    Label9: TLabel;
    BTListarPedido: TButton;
    Clientes: TTabSheet;
    BTClientes: TButton;
    EditPeso: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditAltura: TEdit;
    Label12: TLabel;
    EditLargura: TEdit;
    Label13: TLabel;
    EditProfundidade: TEdit;
    Label14: TLabel;
    EditMPN: TEdit;
    Label15: TLabel;
    EDComEstoque: TEdit;
    EDSemEstoque: TEdit;
    EDQuantidade: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    BTAlterarEstoque: TButton;
    procedure BTListarProdClick(Sender: TObject);
    procedure BTEstoqueClick(Sender: TObject);
     procedure Button3Click(Sender: TObject);
    procedure BTValorProdClick(Sender: TObject);
    procedure BTAlterarValorClick(Sender: TObject);
    procedure BTListarPedidoClick(Sender: TObject);
    procedure BTClientesClick(Sender: TObject);
    procedure BTAlterarEstoqueClick(Sender: TObject);
   
  private
    procedure JSONListarproduto(const JSONString: string);
    procedure JSONValorproduto(const JSONString: string);
    procedure JSONCadastrodeproduto(const JSONString: string);
    procedure JSONListarvalorproduto(const JSONString: string);
    procedure JSONListarpedidos(const JSONString: string);
    procedure JSONListarClientes(const JSONString: string);
    procedure JSONAlterarValorproduto(const JSONString: string);


    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
   ////////////////////////////////// LISTA PRODUTO /////////////////////
procedure TForm1.BTListarProdClick(Sender: TObject);
var
  NetHTTPClient: TNetHTTPClient;
  URL: string;
  Headers: TArray<TNetHeader>;
  ResponseContent: string;
begin
  MemoResposta.Lines.Clear;
  Memo1.Lines.Clear;
  NetHTTPClient := TNetHTTPClient.Create(nil);
  try
    URL := 'https://api.awsli.com.br/v1/produto';

    SetLength(Headers, 1);
    Headers[0].Name := 'Authorization';
    Headers[0].Value := 'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

    ResponseContent := NetHTTPClient.Get(URL, nil, Headers).ContentAsString;

    // Exibe o JSON completo no Memo1
    Memo1.Lines.Text := ResponseContent;

    // Parse do JSON e exibe a resposta no MemoResposta
    JSONListarproduto(ResponseContent);
  finally
    NetHTTPClient.Free;
  end;
end;

////////////////////////////////// LISTA ESTOQUE /////////////////////

procedure TForm1.BTEstoqueClick(Sender: TObject);
var
  NetHTTPClient: TNetHTTPClient;
  URL: string;
  Headers: TArray<TNetHeader>;
  ResponseContent: string;
begin
  MemoResposta.Lines.Clear;
  Memo1.Lines.Clear;
  NetHTTPClient := TNetHTTPClient.Create(nil);
  try
    URL := 'https://api.awsli.com.br/v1/produto_estoque';

    SetLength(Headers, 1);
    Headers[0].Name := 'Authorization';
    Headers[0].Value :=  'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;;

    ResponseContent := NetHTTPClient.Get(URL, nil, Headers).ContentAsString;


    Memo1.Lines.Text := ResponseContent;

    JSONValorproduto(ResponseContent);
  finally
    NetHTTPClient.Free;
  end;
end;




 ////////////////////////////////////cadastrar produto/////////////////////////////
procedure TForm1.Button3Click(Sender: TObject);
var
  JSONRequest: TJSONObject;
  ResponseContentCadastro: string;
  RequestStream: TStringStream;
  NetHTTPClient: TNetHTTPClient;
  Headers: TArray<TNetHeader>;
  URL: string;
  Slug: string;
  Apelido: string;
  descricao_completa: string;
begin


    JSONRequest := TJSONObject.Create;
    try
      // Substitui os espaços por underscores no valor do EditNome.Text
      JSONRequest.AddPair('slug', StringReplace(EditNome.Text, ' ', '_', [rfReplaceAll]));
      JSONRequest.AddPair('apelido', StringReplace(EditNome.Text, ' ', '_', [rfReplaceAll]));
      JSONRequest.AddPair('removido', TJSONBool.Create(False));
      JSONRequest.AddPair('id_externo', TJSONNull.Create);
      JSONRequest.AddPair('sku', EditSku.Text);
      JSONRequest.AddPair('mpn', EditMPN.Text);
      JSONRequest.AddPair('ncm', EditNcm.Text);
      JSONRequest.AddPair('nome', EditNome.Text);
      JSONRequest.AddPair('descricao_completa', '');
      JSONRequest.AddPair('grades', '[]');
      JSONRequest.AddPair('ativo', TJSONBool.Create(True));
      JSONRequest.AddPair('destaque', TJSONBool.Create(False));
      JSONRequest.AddPair('peso', EditPeso.Text);
      JSONRequest.AddPair('altura', EditAltura.Text);
      JSONRequest.AddPair('largura', TJSONNull.Create);
      JSONRequest.AddPair('profundidade', TJSONNull.Create);
      JSONRequest.AddPair('tipo', 'normal');
      JSONRequest.AddPair('usado', TJSONBool.Create(False));
      try
      URL := 'https://api.awsli.com.br/v1/produto';

      SetLength(Headers, 2); // Defina o tamanho do array como 2
      Headers[0].Name := 'Content-Type';
      Headers[0].Value := 'application/json';

      // Replace MINHACHAVE and MINHAAPLICAÇÃO with your actual API and application keys
      Headers[1].Name := 'Authorization';
      Headers[1].Value :=  'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

      // Send the POST request to the API
      ResponseContentCadastro := NetHTTPClient.Post(URL, RequestStream, nil, Headers).ContentAsString;


      Memo1.Lines.Text := ResponseContentCadastro;


      JSONCadastrodeproduto(ResponseContentCadastro);
    finally
      JSONRequest.Free;
      NetHTTPClient.Free;
      RequestStream.Free;
      end;
          except
          on E: Exception do
          ShowMessage('Erro ao cadastrar o produto: ' + E.Message);
  end;
  end;


////////////////////////////////////////////////////////////////////////////////////////////////////////
                                        ///      LISTA VALORES DOS PRODUTOS     ///

procedure TForm1.BTValorProdClick(Sender: TObject);
var
  NetHTTPClient: TNetHTTPClient;
  URL: string;
  Headers: TArray<TNetHeader>;
  ResponseContent: string;
begin
  MemoResposta.Lines.Clear;
  Memo1.Lines.Clear;
  NetHTTPClient := TNetHTTPClient.Create(nil);
  try
    URL := 'https://api.awsli.com.br/v1/produto_preco';

    SetLength(Headers, 1);
    Headers[0].Name := 'Authorization';
    Headers[0].Value :=  'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

    ResponseContent := NetHTTPClient.Get(URL, nil, Headers).ContentAsString;

    // Exibe o JSON completo no Memo1
    Memo1.Lines.Text := ResponseContent;

    // Parse do JSON e exibe a resposta no MemoResposta
    JSONListarvalorproduto(ResponseContent);
  finally
    NetHTTPClient.Free;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////
                              ////            botao de alterar valores          /////
procedure TForm1.BTAlterarValorClick(Sender: TObject);
var
  JSONRequest: TJSONObject;
  ResponseContent: string;
  HTTPClient: THTTPClient;
  RequestContent: TStringStream;
  Response: IHTTPResponse;
  URL: string;
  IDProd: string;
begin
  try
    // Lê o ID do produto
    IDProd := EditIDProd.Text;

    // Cria o objeto JSON com os dados dos preços a serem atualizados
    JSONRequest := TJSONObject.Create;
    JSONRequest.AddPair('cheio', TJSONNumber.Create(StrToFloat(EditValorCheio.Text)));
    JSONRequest.AddPair('custo', TJSONNumber.Create(StrToFloat(EditValorCusto.Text)));
    JSONRequest.AddPair('promocional', TJSONNumber.Create(StrToFloat(EditValorPromocional.Text)));

    // Cria o componente HTTPClient
    HTTPClient := THTTPClient.Create;
    RequestContent := TStringStream.Create(JSONRequest.ToString, TEncoding.UTF8);

    try
      // Configura o componente HTTPClient
      HTTPClient.ContentType := 'application/json';

      // Adiciona a autorização no cabeçalho
      HTTPClient.CustomHeaders['Authorization'] := 'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

      // Monta a URL da requisição PUT
      URL := 'https://api.awsli.com.br/v1/produto_preco/' + IDProd;

      // Envia a requisição PUT e recebe a resposta
      Response := HTTPClient.Put(URL, RequestContent);

      // Obtém o conteúdo da resposta
      ResponseContent := Response.ContentAsString;

      // Exibe o JSON no Memo1
      Memo1.Lines.Text := JSONRequest.ToString;

      if Response.StatusCode = 200 then
      begin
        ShowMessage('Requisição PUT bem-sucedida!');
        // Você pode fazer algo adicional aqui, caso necessário.
      end
      else
      begin
        ShowMessage('Erro na requisição PUT: ' + Response.StatusText);
      end;

      // Exibe a resposta no MemoResposta usando a procedure JSONAlterarValorproduto
      JSONAlterarValorproduto(ResponseContent);
    finally
      JSONRequest.Free;
      HTTPClient.Free;
      RequestContent.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao atualizar os preços do produto: ' + E.Message);
  end;
end;






////////////////////////////////////////////////////////////////////////////////////////////////////////
                              ////     botao de Listar Pedidos   /////
procedure TForm1.BTListarPedidoClick(Sender: TObject);
var
  NetHTTPClient: TNetHTTPClient;
  URL: string;
  Headers: TArray<TNetHeader>;
  ResponseContent: string;
begin
  MemoResposta.Lines.Clear;
  Memo1.Lines.Clear;
  NetHTTPClient := TNetHTTPClient.Create(nil);
  try
    URL := 'https://api.awsli.com.br/v1/situacao';

    SetLength(Headers, 1);
    Headers[0].Name := 'Authorization';
    Headers[0].Value := 'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

    ResponseContent := NetHTTPClient.Get(URL, nil, Headers).ContentAsString;

    // Exibe o JSON completo no Memo1
    Memo1.Lines.Text := ResponseContent;

    // Parse do JSON e exibe a resposta no MemoResposta
    JSONListarpedidos(ResponseContent);
  finally
    NetHTTPClient.Free;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////
               ////     botao de Listar Clientes  /////
procedure TForm1.BTClientesClick(Sender: TObject);

var
  NetHTTPClient: TNetHTTPClient;
  URL: string;
  Headers: TArray<TNetHeader>;
  ResponseContent: string;
begin
  MemoResposta.Lines.Clear;
  Memo1.Lines.Clear;
  NetHTTPClient := TNetHTTPClient.Create(nil);
  try
    URL := 'https://api.awsli.com.br/v1/cliente';

    SetLength(Headers, 1);
    Headers[0].Name := 'Authorization';
    Headers[0].Value := 'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

    ResponseContent := NetHTTPClient.Get(URL, nil, Headers).ContentAsString;

    // Exibe o JSON completo no Memo1
    Memo1.Lines.Text := ResponseContent;

    // Parse do JSON e exibe a resposta no MemoResposta
    JSONListarClientes(ResponseContent);
  finally
    NetHTTPClient.Free;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////
               ////     botao de Alterar Estoque  /////
procedure TForm1.BTAlterarEstoqueClick(Sender: TObject);
var
  JSONRequest: TJSONObject;
  ResponseContent: string;
  HTTPClient: THTTPClient;
  RequestContent: TStringStream;
  Response: IHTTPResponse;
  URL: string;
  EditIDProd: string;
begin
  MemoResposta.Lines.Clear;

  try
    // Cria o objeto JSON com os dados do estoque a serem atualizados
    JSONRequest := TJSONObject.Create;
    JSONRequest.AddPair('gerenciado', TJSONBool.Create(True));
    JSONRequest.AddPair('situacao_em_estoque', TJSONNumber.Create(StrToFloat(EDComEstoque.Text)));
    JSONRequest.AddPair('situacao_sem_estoque', TJSONNumber.Create(StrToFloat(EDSemEstoque.Text)));
    JSONRequest.AddPair('quantidade', TJSONNumber.Create(StrToFloat(EDQuantidade.Text)));

    // Cria o componente HTTPClient
    HTTPClient := THTTPClient.Create;
    RequestContent := TStringStream.Create(JSONRequest.ToString, TEncoding.UTF8);

    try
      // Configura o componente HTTPClient
      HTTPClient.ContentType := 'application/json';

      // Adiciona a autorização no cabeçalho
      HTTPClient.CustomHeaders['Authorization'] := 'chave_api ' + EditChave.Text + ' aplicacao ' + EditSenha.Text;

      // Envia a requisição PUT e recebe a resposta
      URL := 'https://api.awsli.com.br/v1/produto_estoque/' + EditIDProd;
      Response := HTTPClient.Put(URL, RequestContent);  // Moveu esta linha para cá

      // Verifica a resposta da requisição
      if Response.StatusCode = 200 then
      begin
        ShowMessage('Requisição PUT bem-sucedida!');
        // Você pode fazer algo adicional aqui, caso necessário.
      end
      else
      begin
        ShowMessage('Erro na requisição PUT: ' + Response.StatusText);
        MemoResposta.Lines.Text := Response.ContentAsString; // Exibe a resposta no MemoResposta
      end;
    finally
      JSONRequest.Free;
      HTTPClient.Free;
      RequestContent.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao atualizar o estoque do produto: ' + E.Message);
  end;
end;





















































//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////        ****     FILTRO DE JSON     ****   //////////////////////
////////////////////////                                          //////////////////////
////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          /// FILTRA O JSON DO BOTAO LISTAR PRODUTO ///


procedure TForm1.JSONListarproduto(const JSONString: string);
var
  JSONObject, metaObject, currentObject: TJSONObject;
  objectsArray: TJSONArray;
  limit, offset, total_count: Integer;
  apelido, descricao_completa, gtin, mpn, ncm, nome, resource_uri, seo, sku, tipo, url, url_video_youtube: string;
  produtoId, I, produtoCount: Integer;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // Limpa o MemoResposta antes de adicionar novas linhas
    MemoResposta.Lines.Clear;
    produtoCount := 0;
    // Verifica se o JSON contém o array "objects"
    if Assigned(JSONObject.Values['objects']) and (JSONObject.Values['objects'] is TJSONArray) then
    begin
      objectsArray := JSONObject.Values['objects'] as TJSONArray;
      // Itera sobre os elementos do array "objects"
      for I := 0 to objectsArray.Count - 1 do
      begin
        currentObject := objectsArray.Items[I] as TJSONObject;

        // Acessa os campos específicos do objeto "objects"
        produtoId := currentObject.GetValue<Integer>('id');
        apelido := StringReplace(apelido, '-', ' ', [rfReplaceAll]); // Substitui '-' por espaço

        // Verifica se o JSON contém os campos "ativo" e "bloqueado"
        if Assigned(currentObject.Values['ativo']) and (currentObject.Values['ativo'] is TJSONBool) then
        begin
          // Aqui você pode fazer algo com o valor do campo "ativo"
          // Por exemplo, você pode adicionar ao MemoResposta:
          MemoResposta.Lines.Add('Ativo: ' + BoolToStr(currentObject.GetValue<Boolean>('ativo'), True));
        end;

        if Assigned(currentObject.Values['bloqueado']) and (currentObject.Values['bloqueado'] is TJSONBool) then
        begin
          // Aqui você pode fazer algo com o valor do campo "bloqueado"
          // Por exemplo, você pode adicionar ao MemoResposta:
          MemoResposta.Lines.Add('Bloqueado: ' + BoolToStr(currentObject.GetValue<Boolean>('bloqueado'), True));
        end;

        gtin := currentObject.GetValue<string>('gtin');
        mpn := currentObject.GetValue<string>('mpn');
        ncm := currentObject.GetValue<string>('ncm');
        nome := currentObject.GetValue<string>('nome');
        resource_uri := currentObject.GetValue<string>('resource_uri');
        seo := currentObject.GetValue<string>('seo');
        sku := currentObject.GetValue<string>('sku');
        tipo := currentObject.GetValue<string>('tipo');
        url := currentObject.GetValue<string>('url');
        url_video_youtube := currentObject.GetValue<string>('url_video_youtube');

        Inc(produtoCount);
        // Exibe os campos no MemoResposta
        MemoResposta.Lines.Add('Produto: '           + IntToStr(produtoCount));
        MemoResposta.Lines.Add('ID: '                + IntToStr(produtoId));
        MemoResposta.Lines.Add('Nome: '              + nome);
        MemoResposta.Lines.Add('GTIN: '              + gtin);
        MemoResposta.Lines.Add('MPN: '               + mpn);
        MemoResposta.Lines.Add('NCM: '               + ncm);
        MemoResposta.Lines.Add('Resource URI: '      + resource_uri);
        MemoResposta.Lines.Add('SEO: '               + seo);
        MemoResposta.Lines.Add('SKU: '               + sku);
        MemoResposta.Lines.Add('Tipo: '              + tipo);
        MemoResposta.Lines.Add('URL: '               + url);
        MemoResposta.Lines.Add('URL Video YouTube: ' + url_video_youtube);
        MemoResposta.Lines.Add('----------------------------------------------------------------------------------------');
      end;
    end;
  finally
    JSONObject.Free;
  end;
end;




///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          /// FILTRA O JSON DO BOTAO ESTOQUE DE PRODUTO ///

procedure TForm1.JSONValorproduto(const JSONString: string);
var
  JSONObject, currentObject: TJSONObject;
  objectsArray: TJSONArray;
  I, produtoCount: Integer;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // Limpa o MemoResposta antes de adicionar novas linhas
    MemoResposta.Lines.Clear;
    produtoCount := 0;

    // Verifica se o JSON contém o array "objects"
    if Assigned(JSONObject.Values['objects']) and (JSONObject.Values['objects'] is TJSONArray) then
    begin
      objectsArray := JSONObject.Values['objects'] as TJSONArray;
      // Itera sobre os elementos do array "objects"
      for I := 0 to objectsArray.Count - 1 do
      begin
        currentObject := objectsArray.Items[I] as TJSONObject;

        // Verifica se o objeto possui a tag "gerenciado" igual a false
        if (currentObject.GetValue<Boolean>('gerenciado') = False) then
        begin
          Inc(produtoCount);


          // Exibe os campos no MemoResposta
          MemoResposta.Lines.Add('Produto '                + IntToStr(produtoCount) + ':');
          MemoResposta.Lines.Add('ID: '                    + currentObject.GetValue<string>('id'));
          MemoResposta.Lines.Add('Produto: '               + currentObject.GetValue<string>('produto'));
          MemoResposta.Lines.Add('Quantidade: '            + currentObject.GetValue<string>('quantidade'));
          MemoResposta.Lines.Add('Quantidade Disponível: ' + currentObject.GetValue<string>('quantidade_disponivel'));
          MemoResposta.Lines.Add('Quantidade Reservada: '  + currentObject.GetValue<string>('quantidade_reservada'));
          MemoResposta.Lines.Add('Resource URI: '          + currentObject.GetValue<string>('resource_uri'));
          MemoResposta.Lines.Add('Situacao em Estoque: '   + currentObject.GetValue<string>('situacao_em_estoque'));
          MemoResposta.Lines.Add('Situacao sem Estoque: '  + currentObject.GetValue<string>('situacao_sem_estoque'));
          MemoResposta.Lines.Add('----------------------------------------------------------------------------------------');
        end;
      end;

      if produtoCount = 0 then
        MemoResposta.Lines.Add('Nenhum produto encontrado com a tag "gerenciado" igual a false.');
    end
    else
      MemoResposta.Lines.Add('Nenhum objeto "objects" encontrado no JSON.');
  finally
    JSONObject.Free;
  end;
end;









///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          /// FILTRA O JSON DO BOTAO CADASTRO DE PRODUTO ///

procedure TForm1.JSONCadastrodeproduto(const JSONString: string);
var
  JSONObject: TJSONObject;
  apelido, descricao_completa, gtin, mpn, ncm, nome, sku, tipo, url: string;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // Limpa o MemoResposta antes de adicionar novas linhas
    MemoResposta.Lines.Clear;

    // Acessa os campos específicos do JSON
    apelido := JSONObject.GetValue<string>('apelido');
    descricao_completa := JSONObject.GetValue<string>('descricao_completa');
    gtin := JSONObject.GetValue<string>('gtin');
    mpn := JSONObject.GetValue<string>('mpn');
    ncm := JSONObject.GetValue<string>('ncm');
    nome := JSONObject.GetValue<string>('nome');
    sku := JSONObject.GetValue<string>('sku');
    tipo := JSONObject.GetValue<string>('tipo');
    url := JSONObject.GetValue<string>('url');

    // Exibe os valores dos campos específicos no MemoResposta
    MemoResposta.Lines.Add('Apelido: '            + apelido);
    MemoResposta.Lines.Add('Descrição Completa: ' + descricao_completa);
    MemoResposta.Lines.Add('GTIN: '               + gtin);
    MemoResposta.Lines.Add('MPN: '                + mpn);
    MemoResposta.Lines.Add('NCM: '                + ncm);
    MemoResposta.Lines.Add('Nome: '               + nome);
    MemoResposta.Lines.Add('SKU: '                + sku);
    MemoResposta.Lines.Add('Tipo: '               + tipo);
    MemoResposta.Lines.Add('URL: '                + url);

  finally
    JSONObject.Free;
  end;
end;


 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ///FILTRA O JSON DO BOTAO VALOR DOS PRODUTOS  ///

procedure TForm1.JSONListarvalorproduto(const JSONString: string);
var
  JSONObject, metaObject, currentObject: TJSONObject;
  objectsArray: TJSONArray;
  limit, offset, total_count: Integer;
  cheio, custo, id, produto, promocional, resource_uri: string;
  sob_consulta: Boolean;
  I: Integer;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // Limpa o MemoResposta antes de adicionar novas linhas
    MemoResposta.Lines.Clear;

    // Verifica se o JSON contém o array "objects"
    if Assigned(JSONObject.Values['objects']) and (JSONObject.Values['objects'] is TJSONArray) then
    begin
      objectsArray := JSONObject.Values['objects'] as TJSONArray;

      // Itera sobre os elementos do array "objects"
      for I := 0 to objectsArray.Count - 1 do
      begin
        currentObject := objectsArray.Items[I] as TJSONObject;

        // Acessa os campos específicos do objeto "objects"
        cheio := currentObject.GetValue<string>('cheio');
        custo := currentObject.GetValue<string>('custo');
        id := currentObject.GetValue<string>('id');
        produto := currentObject.GetValue<string>('produto');
        promocional := currentObject.GetValue<string>('promocional');
        resource_uri := currentObject.GetValue<string>('resource_uri');
        sob_consulta := currentObject.GetValue<Boolean>('sob_consulta');

        // Exibe os valores dos campos específicos no MemoResposta
        MemoResposta.Lines.Add('Varlo do Produto: '     + cheio);
        MemoResposta.Lines.Add('Custo do Produto: '     + custo);
        MemoResposta.Lines.Add('ID: '                   + id);
        MemoResposta.Lines.Add('Produto: '              + produto);
        MemoResposta.Lines.Add('Promocional: '          + promocional);
        MemoResposta.Lines.Add('Resource URI: '         + resource_uri);
        MemoResposta.Lines.Add('Sob Consulta: '         + BoolToStr(sob_consulta, True));
        MemoResposta.Lines.Add('----------------------------------------------------------------------------------------');
      end;
    end
    else
      MemoResposta.Lines.Add('Nenhum objeto "objects" encontrado no JSON.');

  finally
    JSONObject.Free;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          /// FILTRA O JSON DO BOTAO LISTAR PEDIDOS ///

procedure TForm1.JSONListarpedidos(const JSONString: string);
var
  JSONObject, currentObject: TJSONObject;
  objectsArray: TJSONArray;
  aprovado, cancelado, codigo, final, nome, notificar_comprador, padrao, resource_uri: string;
  id, produtoCount: Integer;
  I: Integer;
  ModifiedJSON: string;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // Limpa o MemoResposta antes de adicionar novas linhas
    MemoResposta.Lines.Clear;

    // Verifica se o JSON contém o array "objects"
    if Assigned(JSONObject.Values['objects']) and (JSONObject.Values['objects'] is TJSONArray) then
    begin
      objectsArray := JSONObject.Values['objects'] as TJSONArray;

      // Itera sobre os elementos do array "objects"
      for I := 0 to objectsArray.Count - 1 do
      begin
        currentObject := objectsArray.Items[I] as TJSONObject;

        // Recupera os valores das tags e renomeia
        aprovado := currentObject.GetValue<string>('aprovado');
        cancelado := currentObject.GetValue<string>('cancelado');
        codigo := currentObject.GetValue<String>('codigo');
        final := currentObject.GetValue<string>('final');
        id := currentObject.GetValue<Integer>('id');
        nome := currentObject.GetValue<string>('nome');
        notificar_comprador := currentObject.GetValue<string>('notificar_comprador');
        padrao := currentObject.GetValue<string>('padrao');
        resource_uri := currentObject.GetValue<string>('resource_uri');

        // Exibe os campos no MemoResposta
        MemoResposta.Lines.Add('Aprovado: '            + StringReplace(aprovado, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('Cancelado: '           + StringReplace(cancelado, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('Código: '              + StringReplace(codigo, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('Final: '               + StringReplace(final, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('ID: '                  + IntToStr(id));
        MemoResposta.Lines.Add('Nome: '                + StringReplace(nome, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('Notificar Comprador: ' + StringReplace(notificar_comprador, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('Padrão: '              + StringReplace(padrao, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('Resource URI: '        + StringReplace(resource_uri, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('----------------------------------------------------------------------------------------');
      end;
    end;
  finally
    JSONObject.Free;
  end;
end;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          /// FILTRA O JSON DO BOTAO LISTAR CLIENTES ///

procedure TForm1.JSONListarClientes(const JSONString: string);
var
  JSONObject, currentObject: TJSONObject;
  objectsArray: TJSONArray;
  email, nome, razao_social, sexo, tipo, cnpj: string;
  cpf, data_criacao, data_modificacao, data_nascimento, id, ie, rg: Variant;
  I: Integer;
  cnpjValue, cpfValue, data_criacaoValue, data_modificacaoValue, data_nascimentoValue,
    idValue, ieValue, rgValue: TJSONValue;

begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try

    MemoResposta.Lines.Clear;
     Memo1.Lines.Clear;
    // Verifica se o JSON contém o array "objects"
    if Assigned(JSONObject.Values['objects']) and (JSONObject.Values['objects'] is TJSONArray) then
    begin
      objectsArray := JSONObject.Values['objects'] as TJSONArray;

      // Itera sobre os elementos do array "objects"
      for I := 0 to objectsArray.Count - 1 do
      begin
        currentObject := objectsArray.Items[I] as TJSONObject;

        // Verifica se o campo "cnpj" não é nulo
        cnpjValue := currentObject.GetValue('cnpj');
        if not (cnpjValue is TJSONNull) then
          cnpj := cnpjValue.Value
        else
          cnpj := 'null';

        // Recupera os valores das tags
        email := currentObject.GetValue<string>('email');
        nome := currentObject.GetValue<string>('nome');
        razao_social := currentObject.GetValue<string>('razao_social');
        sexo := currentObject.GetValue<string>('sexo');
        cpfValue := currentObject.GetValue('cpf');
        data_criacaoValue := currentObject.GetValue('data_criacao');
        data_modificacaoValue := currentObject.GetValue('data_modificacao');
        data_nascimentoValue := currentObject.GetValue('data_nascimento');
        idValue := currentObject.GetValue('id');
        ieValue := currentObject.GetValue('ie');
        rgValue := currentObject.GetValue('rg');
        tipo := currentObject.GetValue<string>('tipo');

        // Converte os valores para tipos Variant
        cpf := VarToStrDef(cpfValue.Value, 'null');
        data_criacao := VarToStrDef(data_criacaoValue.Value, 'null');
        data_modificacao := VarToStrDef(data_modificacaoValue.Value, 'null');
        data_nascimento := VarToStrDef(data_nascimentoValue.Value, 'null');
        id := VarToStrDef(idValue.Value, 'null');
        ie := VarToStrDef(ieValue.Value, 'null');
        rg := VarToStrDef(rgValue.Value, 'null');

        // Exibe os campos no MemoResposta
        MemoResposta.Lines.Add('email: ' + StringReplace(email, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('nome: ' + StringReplace(nome, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('razao_social: ' + StringReplace(razao_social, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('sexo: ' + StringReplace(sexo, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('cnpj: ' + cnpj);
        MemoResposta.Lines.Add('cpf: ' + cpf);
        MemoResposta.Lines.Add('data_criacao: ' + data_criacao);
        MemoResposta.Lines.Add('data_modificacao: ' + data_modificacao);
        MemoResposta.Lines.Add('data_nascimento: ' + data_nascimento);
        MemoResposta.Lines.Add('id: ' + id);
        MemoResposta.Lines.Add('ie: ' + ie);
        MemoResposta.Lines.Add('rg: ' + rg);
        MemoResposta.Lines.Add('Tipo: ' + StringReplace(tipo, '_', ' ', [rfReplaceAll]));
        MemoResposta.Lines.Add('----------------------------------------------------------------------------------------');
      end;
    end;
  finally
    JSONObject.Free;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          /// FILTRA O JSON DO BOTAO ALTERAÇÃO DE VALORES DOS PRODUTOS ///

procedure TForm1.JSONAlterarValorproduto(const JSONString: string);
var
  JSONObject: TJSONObject;
  cheio, custo, id, produto, promocional, resource_uri: string;
  sob_consulta: Boolean;
begin
  JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;
  try
    // Limpa o MemoResposta antes de adicionar novas linhas
    MemoResposta.Lines.Clear;

    if Assigned(JSONObject) then
    begin
      // Acessa os campos do objeto JSON
      cheio := JSONObject.GetValue<string>('cheio');
      custo := JSONObject.GetValue<string>('custo');
      id := JSONObject.GetValue<string>('id');
      produto := JSONObject.GetValue<string>('produto');
      promocional := JSONObject.GetValue<string>('promocional');
      resource_uri := JSONObject.GetValue<string>('resource_uri');
      sob_consulta := JSONObject.GetValue<Boolean>('sob_consulta');

      // Exibe os valores dos campos no MemoResposta
      MemoResposta.Lines.Add('Valor do Produto: '     + cheio);
      MemoResposta.Lines.Add('Custo do Produto: '     + custo);
      MemoResposta.Lines.Add('ID: '                   + id);
      MemoResposta.Lines.Add('Produto: '              + produto);
      MemoResposta.Lines.Add('Promocional: '          + promocional);
      MemoResposta.Lines.Add('Resource URI: '         + resource_uri);
      MemoResposta.Lines.Add('Sob Consulta: '         + BoolToStr(sob_consulta, True));
      MemoResposta.Lines.Add('----------------------------------------------------------------------------------------');
    end
    else
    begin
      MemoResposta.Lines.Add('Erro ao analisar o JSON.');
    end;
  finally
    JSONObject.Free;
  end;
end;















end.
