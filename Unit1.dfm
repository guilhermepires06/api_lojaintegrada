object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Loja Integrada'
  ClientHeight = 580
  ClientWidth = 1234
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    1234
    580)
  TextHeight = 15
  object Memo1: TMemo
    Left = -2
    Top = 175
    Width = 732
    Height = 404
    Anchors = [akLeft, akTop, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object MemoResposta: TMemo
    Left = 736
    Top = 0
    Width = 493
    Height = 579
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 3
    Width = 731
    Height = 166
    ActivePage = Configuracao
    TabOrder = 2
    object Clientes: TTabSheet
      Caption = 'Clientes'
      ImageIndex = 4
      object BTListarPedido: TButton
        Left = 0
        Top = 63
        Width = 169
        Height = 33
        Caption = 'Listar Pedidos'
        TabOrder = 0
        OnClick = BTListarPedidoClick
      end
      object BTClientes: TButton
        Left = 0
        Top = 3
        Width = 169
        Height = 33
        Caption = 'Listar Clientes'
        TabOrder = 1
        OnClick = BTClientesClick
      end
    end
    object VerificarProdutos: TTabSheet
      Caption = 'Verificar Produtos'
      ImageIndex = 1
      object BTListarProd: TButton
        Left = 2
        Top = 6
        Width = 169
        Height = 33
        Caption = 'Listar Produtos'
        TabOrder = 0
        OnClick = BTListarProdClick
      end
      object BTEstoque: TButton
        Left = 2
        Top = 50
        Width = 169
        Height = 33
        Caption = 'Estoque'
        TabOrder = 1
        OnClick = BTEstoqueClick
      end
      object BTValorProd: TButton
        Left = 187
        Top = 6
        Width = 169
        Height = 33
        Caption = 'Valor dos Produtos'
        TabOrder = 2
        OnClick = BTValorProdClick
      end
    end
    object CadastrarProdutos: TTabSheet
      Caption = 'Cadastrar produtos'
      ImageIndex = 1
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 96
        Height = 15
        Caption = 'Nome do Produto'
      end
      object Label2: TLabel
        Left = 300
        Top = -2
        Width = 21
        Height = 15
        Caption = 'SKU'
      end
      object Label3: TLabel
        Left = 427
        Top = -2
        Width = 28
        Height = 15
        Caption = 'NCM'
      end
      object Label10: TLabel
        Left = 172
        Top = 42
        Width = 25
        Height = 15
        Caption = 'Peso'
      end
      object Label11: TLabel
        Left = 295
        Top = 40
        Width = 32
        Height = 15
        Caption = 'Altura'
      end
      object Label12: TLabel
        Left = 424
        Top = 40
        Width = 40
        Height = 15
        Caption = 'Largura'
      end
      object Label13: TLabel
        Left = 548
        Top = 40
        Width = 72
        Height = 15
        Caption = 'Profundidade'
      end
      object Label14: TLabel
        Left = 3
        Top = 42
        Width = 27
        Height = 15
        Caption = 'MPN'
      end
      object Label15: TLabel
        Left = 36
        Top = 43
        Width = 128
        Height = 12
        Caption = '(N'#250'mero da pe'#231'a do fabricante.)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Button3: TButton
        Left = 0
        Top = 85
        Width = 166
        Height = 33
        Caption = 'Cadastrar Produto'
        TabOrder = 0
        OnClick = Button3Click
      end
      object EditNome: TEdit
        Left = 0
        Top = 16
        Width = 297
        Height = 23
        TabOrder = 1
      end
      object EditSku: TEdit
        Left = 300
        Top = 16
        Width = 121
        Height = 23
        TabOrder = 2
      end
      object EditNcm: TEdit
        Left = 423
        Top = 16
        Width = 121
        Height = 23
        TabOrder = 3
      end
      object EditPeso: TEdit
        Left = 170
        Top = 56
        Width = 121
        Height = 23
        TabOrder = 4
      end
      object EditAltura: TEdit
        Left = 295
        Top = 56
        Width = 121
        Height = 23
        TabOrder = 5
      end
      object EditLargura: TEdit
        Left = 423
        Top = 56
        Width = 121
        Height = 23
        TabOrder = 6
      end
      object EditProfundidade: TEdit
        Left = 548
        Top = 56
        Width = 121
        Height = 23
        TabOrder = 7
      end
      object EditMPN: TEdit
        Left = 0
        Top = 56
        Width = 164
        Height = 23
        TabOrder = 8
      end
    end
    object AlterarProdutos: TTabSheet
      Caption = 'Alterar Produto'
      ImageIndex = 2
      object Label5: TLabel
        Left = 7
        Top = 1
        Width = 132
        Height = 15
        Caption = 'Coloque o ID do produto'
      end
      object Label6: TLabel
        Left = 191
        Top = 1
        Width = 89
        Height = 15
        Caption = 'Valor do Produto'
      end
      object Label7: TLabel
        Left = 186
        Top = 48
        Width = 97
        Height = 15
        Caption = 'Valor Promocional'
      end
      object Label8: TLabel
        Left = 7
        Top = 48
        Width = 76
        Height = 15
        Caption = 'Valor de Custo'
      end
      object Label17: TLabel
        Left = 503
        Top = 1
        Width = 110
        Height = 15
        Caption = 'Situa'#231#227'o em Estoque'
      end
      object Label18: TLabel
        Left = 343
        Top = 1
        Width = 115
        Height = 15
        Caption = 'Situa'#231#227'o sem Estoque'
      end
      object Label19: TLabel
        Left = 343
        Top = 49
        Width = 62
        Height = 15
        Caption = 'Quantidade'
      end
      object EditIDProd: TEdit
        Left = 7
        Top = 20
        Width = 173
        Height = 23
        TabOrder = 0
      end
      object BTAlterarValor: TButton
        Left = 7
        Top = 93
        Width = 154
        Height = 40
        Caption = 'Alterar Valores'
        TabOrder = 1
        OnClick = BTAlterarValorClick
      end
      object EditValorCheio: TEdit
        Left = 186
        Top = 20
        Width = 140
        Height = 23
        TabOrder = 2
      end
      object EditValorCusto: TEdit
        Left = 7
        Top = 65
        Width = 173
        Height = 23
        TabOrder = 3
      end
      object EditValorPromocional: TEdit
        Left = 186
        Top = 65
        Width = 140
        Height = 23
        TabOrder = 4
      end
      object EDComEstoque: TEdit
        Left = 503
        Top = 20
        Width = 145
        Height = 23
        TabOrder = 5
      end
      object EDSemEstoque: TEdit
        Left = 343
        Top = 20
        Width = 145
        Height = 23
        TabOrder = 6
      end
      object EDQuantidade: TEdit
        Left = 343
        Top = 65
        Width = 145
        Height = 23
        TabOrder = 7
      end
      object BTAlterarEstoque: TButton
        Left = 343
        Top = 94
        Width = 154
        Height = 40
        Caption = 'Alterar Estoque'
        TabOrder = 8
        OnClick = BTAlterarEstoqueClick
      end
    end
    object Configuracao: TTabSheet
      Caption = 'Configuracao'
      ImageIndex = 3
      object Label4: TLabel
        Left = 3
        Top = 51
        Width = 55
        Height = 15
        Caption = 'Aplica'#231#227'o:'
      end
      object Label9: TLabel
        Left = 0
        Top = 6
        Width = 74
        Height = 15
        Caption = 'Chave Da API:'
      end
      object EditChave: TEdit
        Left = 80
        Top = 3
        Width = 350
        Height = 23
        TabOrder = 0
      end
      object EditSenha: TEdit
        Left = 80
        Top = 48
        Width = 350
        Height = 23
        TabOrder = 1
      end
    end
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 784
    Top = 8
  end
  object NetHTTPRequest1: TNetHTTPRequest
    ConnectionTimeout = 0
    SendTimeout = 0
    ResponseTimeout = 0
    Left = 920
    Top = 8
  end
end
