<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script Language="C#" runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //Obter esses dados a partir da página de contato
            string lstrEmailOrigem = string.Empty;
            string lstrAssunto = string.Empty;
            string lstrMensagem = string.Empty;
            string lstrTelefoneContato = string.Empty;
            string lstrNome = string.Empty;
            
            if (Request.QueryString["txtEmailOrigem"] != null)
                lstrEmailOrigem = Request.QueryString["txtEmailOrigem"];

            if (Request.QueryString["txtTelefoneContato"] != null)
                lstrTelefoneContato = Request.QueryString["txtTelefoneContato"];

            if (Request.QueryString["txtAssunto"] != null)
                lstrAssunto = Request.QueryString["txtAssunto"];

            if (Request.QueryString["txtMensagem"] != null)
                lstrMensagem = Request.QueryString["txtMensagem"];

            if (Request.QueryString["txtNome"] != null)
                lstrNome = Request.QueryString["txtNome"];

            //Obter essa informação em um arquivo Externo
            string lstrEmailDestino = "contato@nmplan.net"; //substitua esse e-mail por qualquer e-mail que vc quer que receba o e-mail enviado.
            string lstrServidorEmail = "www.nmplan.net "; //ip do servidor Wimidia
            string lstrURLRedireciona = "obrigado.html"; //Url de confirmação de e-mail. Após enviar o e-mail o sistema irá redirecionar para a página que vc colocar aqui.

            if (fnValidaCampos(lstrEmailOrigem, lstrTelefoneContato, lstrAssunto, lstrMensagem))
            {
                if (lstrMensagem != string.Empty && lstrEmailOrigem != string.Empty && lstrTelefoneContato != string.Empty)
                    fnEnviaEmail(lstrEmailOrigem, lstrEmailDestino, lstrAssunto, lstrMensagem, lstrTelefoneContato, lstrNome, lstrServidorEmail, lstrURLRedireciona);
            }
        }
        catch (Exception Erro)
        {
            //fnMensagemAlert(Erro.ToString());
            Response.Write(Erro.ToString());
        }
    }

    private bool fnValidaCampos(string astrEmailOrigem, string astrTelefoneContato, string astrAssunto, string astrMensagem)
    {
        try
        {
            bool lblnRet = true;
            if (astrEmailOrigem != string.Empty)
            {
                if (isEmail(astrEmailOrigem) != true)
                {
                    fnMensagemAlert("E-mail inválido.");
                    lblnRet = false;
                }
            }
            
            if (lblnRet)
            {
                if (astrMensagem.Trim() == string.Empty && astrEmailOrigem != string.Empty)
                {
                    fnMensagemAlert("Por favor, informe sua mensagem");
                    lblnRet = false;
                }
            }

            return lblnRet;
        }
        catch (Exception Erro)
        {
            throw Erro;
        }
    }
    
    private bool isEmail(string inputEmail)
    {
        try
        {
            inputEmail = NullToString(inputEmail);
            string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                  @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                  @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            Regex re = new Regex(strRegex);
            if (re.IsMatch(inputEmail))
                return (true);
            else
                return (false);
        }
        catch (Exception Erro)
        {
            throw Erro;
        }
    }

    private string NullToString(string s)
    {
        return (s == null) ? "" : s;
    }
    
    private void fnEnviaEmail(string astrEmailOrigem, string astrEmailDestino, string astrAssunto, string astrMensagem, string astrTelefone, string astrNome, string astrServidor, string astrUrlRedireciona)
    {
        try
        {
            string lstrServidor = string.Empty;
            System.Net.Mail.SmtpClient lobjSmtp = new System.Net.Mail.SmtpClient();

            string lstrMensagem = string.Empty;
            
            lstrMensagem  = "E-mail para contato: " + astrEmailOrigem + Environment.NewLine;
            lstrMensagem += "Telefone para contato: " + astrTelefone + Environment.NewLine;
            lstrMensagem += "Nome: " + astrNome + Environment.NewLine;
            lstrMensagem += "--------------------------------------------------------------------" + Environment.NewLine;
            lstrMensagem += "Assunto: " + astrAssunto + Environment.NewLine;
            lstrMensagem += "Mensagem: " + Environment.NewLine;
            lstrMensagem += astrMensagem;
                
            lobjSmtp.Host = astrServidor;
            lobjSmtp.Send(astrEmailDestino, astrEmailDestino, astrAssunto, lstrMensagem);

            if(astrUrlRedireciona != string.Empty)
                Response.Redirect(astrUrlRedireciona);
            else
                fnMensagemAlert("Seu e-mail foi enviado com sucesso!");
        }
        catch (Exception Erro)
        {
            throw Erro;
        }        
    }

    private void fnMensagemAlert(string astrMensagem)
    {
        string lstrScript;
        try
        {
            lstrScript = "<script language='javascript'>";
            lstrScript += "   alert('" + astrMensagem + "');";
            lstrScript += "</" + "script>";


            ClientScript.RegisterClientScriptBlock(this.GetType(), "mensagem", lstrScript);
        }
        catch (Exception Erro)
        {
            Response.Write(Erro.ToString());
        }
    }
    
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta name="description" content="Contato - Nmplan Benefícios Financeiros - Recuperação de INSS, Revisão de Impostos Diretos, Sistemas Fiscais - SPED e NFe, Redução de Custos e Despesas, Créditos Estaduais e Federais." />
<meta name="robots" content="index,follow" />
<meta name="keywords" content="Contato, e-mail, conato, e-mail, email, Recuperação de INSS, Revisão de Impostos Diretos, Sistemas Fiscais - SPED e NFe, Redução de Custos e Despesas, Créditos Estaduais e Federais, Totvs, Softteam, COFINS, NFe" />
<meta name="author" content="rafael.aca" />
<meta name="copyright" content="Copyright © 2008-2009 Nmplan.Net benefícios financeiros. Todos os direitos reservados." />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<title>Contato - Nmplan - Benefícios Financeiros - Recuperação de INSS, Revisão de Impostos Diretos, Sistemas Fiscais - SPED e NFe, Redução de Custos e Despesas, Créditos Estaduais e Federais</title>

<link href="css/cssDefault.css" rel="stylesheet" type="text/css" />
<link href="css/cssContato.css" rel="stylesheet" type="text/css" />

</head>

<body>

    <div id="topo">
    	<div id="titulo_site">
        	<a href="index.html" target="_parent"><img src="img/img_Nmplan_menor.jpg" alt="nmplan benefícios financeiros" /></a>
        </div>
    </div>
    <div id="menu">
    	<a href="index.html" ><img src="img/imgBtnHome.jpg" alt="Home" style="border:none;" border="0" id="imgHome" /></a>
        <a href="produtos.html"><img src="img/imgBtnProdutos.jpg" alt="Produtos" style="border:none;" border="0" /></a>
        <a href="#"><img src="img/imgBtnClientes.jpg" alt="Clientes" style="border:none;" border="0" /></a>
        <a href="contato.aspx"><img src="img/imgBtnContato_destaque.jpg" alt="Contatos" style="border:none;" border="0" /></a>
    </div>
    <div id="imagem_pagina">
          <img src="img/imgMeioContato_01_menor.jpg" alt="Nmplan - Benefícios Financeiros - Contato"  />
    </div>

    <div id="corpo_pagina">
			<table id="tableCorpoPagina"  cellpadding="0" cellspacing="0" border="0">
        	<tr id="trTopo" >
                <td id="tdSE" width="5%"></td>
                <td id="tdSC" width="90%" ></td>
                <td id="tdSD" width="5%"></td>
          </tr>
            <tr>
                <td id="tdCE" ></td>
                <td id="tdCC" >
                	<div id="#conteudo">
                    	<div id="divFormContato">
                        	<form action="contato.aspx" method="get" name="frmWimidiaContato" id="frmWimidiaContato" runat="server">
                                <table cellpadding="0" cellspacing="0" border="0">
                                    <tr>
                                        <td style="width:70px;"><span class="clsLabel"> Nome: </span> </td>
                                        <td> <input type="text" name="txtNome"  id="txtNome" value="" size="50" /> </td>
                                    </tr> 
                                    <tr>
                                        <td><span class="clsLabel"> Telefone: </span></td>
                                        <td> <input type="text" name="txtTelefoneContato" id="txtTelefoneContato" value="" size="30" /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="clsLabel"> E-mail: </span></td>
                                        <td><input type="text" name="txtEmailOrigem" id="txtEmailOrigem" value="" size="50" /></td>
                                    </tr>
                                    <tr>
                                        <td> <span class="clsLabel"> Assunto: </span></td>
                                        <td><input type="text" name="txtAssunto" id="txtAssunto" value="" size="50" /></td>
                                    </tr>
                                    <tr>
                                        <td><span class="clsLabel"> Mensgem: </span></td>
                                        <td><textarea name="txtMensagem" id="txtMensagem" cols="40" rows="7"></textarea></td>
                                    </tr>
                                    <tr>
                                    	<td></td>
                                    	<td>
                                        	<input name="submit" type="submit" id="btnEnviar" value="Enviar" />
                                            <input name="reset" type="reset" id="btnLimpar" value="Limpar" />
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
						<div id="divMapa">
                        	<iframe width="380" height="300" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com.br/maps/ms?ie=UTF8&amp;msa=0&amp;msid=109912859672801510264.000467d68430353a059ea&amp;ll=-23.546206,-46.653914&amp;spn=0.011803,0.016308&amp;z=15&amp;output=embed"></iframe><br /><small>Visualizar <a href="http://maps.google.com.br/maps/ms?ie=UTF8&amp;msa=0&amp;msid=109912859672801510264.000467d68430353a059ea&amp;ll=-23.546206,-46.653914&amp;spn=0.011803,0.016308&amp;z=15&amp;source=embed" style="color:#0000FF;text-align:left">R. Dona Antônia de Queirós, 504 - Consolação</a> em um mapa maior</small>
                        </div>
                        <div id="divEndereco">
                        	<ul>
                            	<li><img src="img/imgRodapeTelefone.jpg" alt="Telefone" /> (11)3804-5644 </li>
                                <li><a href="mailto:contato@nmplan.net"><img src="img/imgRodapeEmail.jpg" alt="E-mail" /> contato@nmplan.net </a></li>
                            	<li><img src="img/imgRodapeEndereco.jpg" alt="Endereço" /> R. Dona Antônia de Queirós, 504, cj.62 - Consolação - São Paulo - SP, 01307-010 </li>
							</ul>
                        </div>
                    </div>
              </td>
                <td id="tdCD" ></td>
            </tr>
            <tr height="56">
                <td id="tdIE" ></td>
                <td id="tdIC" ></td>
                <td id="tdID" ></td>
            </tr>
        </table>
		 <div id="divRodapeMenu">
            <ul>	
                <li><a href="prod_recuperacao_inss.html">Recuperação de INSS</a></li>
                <li><a href="prod_revisao_impostos_diretos.html">Revisão de Impostos Diretos</a></li>
                <li><a href="prod_sistemas_fiscais_sped_nfe.html">Sistemas Fiscais - SPED e NFe</a></li>
                <li><a href="prod_reducao_custos_despesas.html">Redução de Custos e Despesas</a></li>
                <li><a href="prod_creditos_estaduais_e_federais.html">Créditos Federais e Estaduais</a></li>
            </ul>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="produtos.html">Produtos</a></li>
                <li><a href="#">Clientes</a></li>
                <li><a href="Contato.aspx">Contato</a></li>
            </ul>
            <div style="margin-top:15px;">
            	Nmplan.net - Benefícios Financeiros - Todos os direitos reservados
            </div>
        </div>
    </div>

    <script type="text/javascript">
	var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
	document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
	</script>
	<script type="text/javascript">
	try {
	var pageTracker = _gat._getTracker("UA-8364750-1");
	pageTracker._trackPageview();
    } catch(err) {}</script>
</body>
</html>

