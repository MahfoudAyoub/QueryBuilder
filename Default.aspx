<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DynamicSQLQuery._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
     <asp:ScriptManager runat="server"> 
     </asp:ScriptManager>

    <style type="text/css">

        #generateur{
          height:500px;
          overflow-y:scroll;
          width:100%;
        }

        #SQLQueryText1{
          height:500px;
          overflow-y:scroll;
          width:100%;
        }

        #results{
          height:500px;
          overflow-y:scroll;
          width:100%;
        }
         
        .tab-content {
            margin-top: 1%;  /*insert n% as per your need*/
        }  
    </style>

    <div class="col-md-12 mt-10">
        <div class="panel panel-default" >
            <div id="Tabs1" role="tabpanel">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs navbar-static-top" id="nav-tab" role="tablist">
                    <li><a href="#generateur" aria-controls="generateur" role="tab" data-toggle="tab">Générateur
                    </a></li>
                    <li><a href="#SQLQueryText1" aria-controls="SQLQueryText1" role="tab" data-toggle="tab">Requête SQL
                    </a></li>
                    <li><a href="#results" aria-controls="employment" role="tab" data-toggle="tab">Résultat</a></li>
                    <asp:Button ID="btnReset" runat="server" Style="margin: 5px; float:right" Text="Reset All" CssClass="btn btn-primary"
                                OnClick="btnReset_Click" />
                    
                    <asp:Button ID="btnRunQuery" Text="Exécuter la requête" Style="margin: 5px; float:right" runat="server" 
                        CssClass="btn btn-primary" OnClick="btnRunQuery_Click" />
                    
                    <asp:Button ID="btngenerate" runat="server" Style="margin: 5px; float:right" Text="Générer la requête" CssClass="btn btn-primary"
                                OnClick="btngenerate_Click" />
                    
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="generateur">
                        <div class="clearfix">
                        </div>
                        <div class="col-md-8 mt-10">
       
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label17" Text="String de connexion" Font-Bold="true" runat="server"></asp:Label></legend>
                                <div class="col-md-3">
                                    <asp:Label ID="Label18" Text="Nom du serveur" Font-Bold="true" runat="server"></asp:Label>
               
                                    <br />
                                     <asp:UpdatePanel ID="UpdatePanelConnect" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                 
                                            <asp:TextBox ID="tbxServerName" runat="server" CssClass="form-control"></asp:TextBox>
                                        </ContentTemplate> 
                 
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnConnect" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
          
                                <div class="col-md-3">
                                    <asp:Label ID="Label21" Text="Id utilisateur" Font-Bold="true" runat="server"></asp:Label> 
                                    <br />
                                     <asp:UpdatePanel ID="UpdatePanel23" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="tbxUserId" runat="server" CssClass="form-control"></asp:TextBox>
                                        </ContentTemplate> 
                 
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnConnect" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-3">
                                    <asp:Label ID="Label22" Text="Mot de passe" Font-Bold="true" runat="server"></asp:Label> 
                                    <br />
                                     <asp:UpdatePanel ID="UpdatePanel24" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="tbxPassword" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>
                                        </ContentTemplate> 
                 
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnConnect" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
       
                                <div class="col-md-2">
                                    <br />
                                  <asp:Button ID="btnConnect" runat="server" Text="Connecter" CssClass="btn btn-primary"
                                         OnClick="btnConnect_Click" /><br />
                                </div>
                                <div class="col-md-4">
                                        <asp:UpdatePanel ID="UpdatePanel25" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                                       <asp:Label ID="lblmsgcon" Text="" ForeColor="#009933" Font-Bold="true" runat="server"></asp:Label>
                                        </ContentTemplate> 
                 
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnConnect" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </fieldset>
                        </div>

  
                        <div class="col-md-4 mt-10">
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label19" Text="Bases de données" Font-Bold="true" runat="server"></asp:Label></legend>
                                <asp:Label ID="Label20" Text="Choisir une base de données" Font-Bold="true" runat="server"></asp:Label><br />
                                <asp:UpdatePanel ID="UpdatePanelDb" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="CmbDatabase" runat="server" CssClass="form-control" AutoPostBack="true"
                                            OnSelectedIndexChanged="CmbDatabase_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                          <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="CmbDatabase" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                   <%--  <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnConnect" EventName="Click" />
                                    </Triggers>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                    </Triggers>--%>
                                </asp:UpdatePanel>
                                <br />
           
                            </fieldset>
                        </div>



                        <div class="col-md-4 mt-10">
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="lbl1" Text="Tables" Font-Bold="true" runat="server"></asp:Label></legend>
                                <asp:Label ID="Label7" Text="Choisir une Table" Font-Bold="true" runat="server"></asp:Label><br />
                                <asp:UpdatePanel ID="UpdatePanelTbl" runat="server" >
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cmbTable" runat="server" CssClass="form-control" AutoPostBack="true"
                                            OnSelectedIndexChanged="CmbTable_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                      <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="CmbDatabase" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel10" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:CheckBoxList ID="FieldNameList" runat="server" CssClass="form-control" Height="300px"
                                            SelectionMode="Multiple" Style="overflow: scroll;">
                                        </asp:CheckBoxList>
                                    </ContentTemplate>
                 
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cmbTable" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ckSelectAllBase" EventName="CheckedChanged" />
                                    </Triggers>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBox ID="ckSelectAllBase" Text="Select All" runat="server" AutoPostBack="true"
                                            OnCheckedChanged="ckSelectAllBase_CheckChanged" />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cmbTable" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </fieldset>

        
                        </div>
    
                        <div class="col-md-8 mt-10">
                            <fieldset class="scheduler-border" id="f1" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label6" Text="Tables de jointure" Font-Bold="true" runat="server"></asp:Label></legend>
                                <div class="col-md-4">
                                    <asp:Label ID="Label2" Text="Choisir une Table de relation" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="cmbRlTable" runat="server" CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="CmbRlTable_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                         <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="CmbRlTable" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel8" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:CheckBoxList ID="RelationFieldNameList" runat="server" CssClass="form-control"
                                                Height="300px" SelectionMode="Multiple" Style="overflow: scroll;">
                                            </asp:CheckBoxList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cmbRlTable" EventName="SelectedIndexChanged" />
                                        </Triggers> 
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:CheckBox ID="ckSelectAllRel" Text="Select All" runat="server" AutoPostBack="true"
                                                OnCheckedChanged="ckSelectAllRel_CheckChanged" />
                                        </ContentTemplate>
                     
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cmbRlTable" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-4">
                                    <asp:Label ID="Label4" Text="Choisir un Colonne" Font-Bold="true" runat="server"></asp:Label><br />
                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="cmbRlColumn" runat="server" CssClass="form-control">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cmbRlTable" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>

                                <div class="col-md-4">
                                    <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                        <legend class="scheduler-border">
                                            <asp:Label ID="Label3" Text="Relation avec" Font-Bold="true" runat="server"></asp:Label></legend>
                                        <asp:Label ID="Label8" Text="Table" Font-Bold="true" runat="server"></asp:Label>
                                        <br />
                                        <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="joinSelectedTable" runat="server" CssClass="form-control" AutoPostBack="true"
                                                    OnSelectedIndexChanged="JoinSelectedTable_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cmbTable" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <br />
                                        <asp:Label ID="Label5" Text="Colonne" Font-Bold="true" runat="server"></asp:Label>
                                        <br />
                                        <asp:UpdatePanel ID="Update15" runat="server">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="cmbBaseTblClmn" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                                <br />
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="joinSelectedTable" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:Button ID="btnAddNewRel" runat="server" Text="Ajouter relation" CssClass="btn btn-primary"  
                                            OnClick="btnAddJoin_Click" />
                                    </fieldset>
                
                                </div>

                                <div class="col-md-12">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblJoin" Font-Size="8" Font-Bold="true" runat="server" Text=""></asp:Label><br />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                
                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                            <ContentTemplate>
                                                <asp:Button ID="btnResetRel" runat="server" Text="Reset Relation" CssClass="btn btn-default"
                                                    OnClick="btnResetRel_Click" />
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>


                                </div>
            

                            </fieldset>
                        </div>
    
                        <%-- <div class="col-md-2 mt-10">
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label3" Text="Relation avec" Font-Bold="true" runat="server"></asp:Label></legend>
                                <asp:Label ID="Label8" Text="Table" Font-Bold="true" runat="server"></asp:Label>
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="joinSelectedTable" runat="server" CssClass="form-control" AutoPostBack="true"
                                            OnSelectedIndexChanged="JoinSelectedTable_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cmbTable" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <br />
                                <asp:Label ID="Label5" Text="Colonne" Font-Bold="true" runat="server"></asp:Label>
                                <br />
                                <asp:UpdatePanel ID="Update15" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cmbBaseTblClmn" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                        <br />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="joinSelectedTable" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <asp:Button ID="btnAddNewRel" runat="server" Text="Ajouter relation" CssClass="btn btn-primary"  
                                    OnClick="btnAddJoin_Click" />
                            </fieldset>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblJoin" Font-Size="8" Font-Bold="true" runat="server" Text=""></asp:Label><br />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnResetRel" runat="server" Text="Reset Relation" CssClass="btn btn-default"
                                        OnClick="btnResetRel_Click" />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnAddNewRel" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>--%>
                        <%-- Condition--%>
    
                        <div class="clearfix">
                        </div>
                        <div class="col-md-12 mt-10">
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label1" Text="Conditions" Font-Bold="true" runat="server"></asp:Label></legend>
                                <div class="col-md-2" >
                                    <asp:Label ID="Label9" Text="Table" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="conditionTbl" runat="server" CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="conditionTbl_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cmbTable" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetRel" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-2">
                                    <asp:Label ID="Label10" Text="Colonne" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="conditionTblClm" runat="server" CssClass="form-control">
                                            </asp:DropDownList>
                                            <br />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="conditionTbl" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-2">
                                    <asp:Label ID="Label11" Text="Operations" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel17" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="conditionalOpCB" runat="server" CssClass="form-control" AutoPostBack="true"
                                                OnSelectedIndexChanged="conditionalOpCB_SelectionChanged">
                                                <asp:ListItem>Selectionner</asp:ListItem>
                                                <asp:ListItem Value="1">Equals</asp:ListItem>
                                                <asp:ListItem Value="2">Not Equals</asp:ListItem>
                                                <asp:ListItem Value="3">Greater Than</asp:ListItem>
                                                <asp:ListItem Value="4">Greater Or Equals</asp:ListItem>
                                                <asp:ListItem Value="5">Less Than</asp:ListItem>
                                                <asp:ListItem Value="6">Less Or Equals</asp:ListItem>
                                                <asp:ListItem Value="7">LIKE</asp:ListItem>
                                                <asp:ListItem Value="8">Not LIKE</asp:ListItem>
                                                <asp:ListItem Value="9">Start With</asp:ListItem>
                                                <asp:ListItem Value="10">End With</asp:ListItem>
                                                <asp:ListItem Value="11">IN</asp:ListItem>
                                                <asp:ListItem Value="12">Not IN</asp:ListItem>
                                                <asp:ListItem Value="13">BETWEEN</asp:ListItem>
                            
                                            </asp:DropDownList>
                                            <asp:Label ID="Label23" Text="*si LIKE: %a% || *si Start With: a% || *si End With: %a " Font-Size="8" runat="server"></asp:Label>

                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetCond" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-3">
                                    <asp:Label ID="Label12" Text="Valeur" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="txtValues" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:Label ID="Label14" Text="* Si la valeur est une date : mm/jj/aaaa" Font-Size="8" runat="server"></asp:Label>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="conditionalOpCB" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetCond" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewCon" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-1">
                                    <asp:Label ID="Label13" Text="AND/OR" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:UpdatePanel ID="UpdatePanel18" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="conditionAndOr" runat="server" Width="80" CssClass="form-control">
                                                <%--<asp:ListItem Value="0" Text=""></asp:ListItem>--%>
                                                <asp:ListItem Value="1">AND</asp:ListItem>
                                                <asp:ListItem Value="2">OR</asp:ListItem>
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnResetCond" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewCon" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-2">
                                    <br />
                                    <asp:Button ID="btnAddNewCon" runat="server" Text="Ajouter condition" CssClass="btn btn-primary"
                                        Style="margin-left: 20px;" OnClick="btnAddCondition_Click" /><br />
                                </div>

                                <div class="col-md-12">
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblWhereTxt" Font-Size="8" Font-Bold="true" runat="server" Text=""></asp:Label><br />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewCon" EventName="Click" />
                                        </Triggers>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                        <ContentTemplate>
                                            <br />
                                            <asp:Button ID="btnResetCond" runat="server" Text="Reset Condition" CssClass="btn btn-primary"
                                                OnClick="btnResetCond_Click" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnAddNewCon" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </fieldset>
                        </div>
    
                        <div class="col-md-6">
                            <%--<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblWhereTxt" Font-Size="8" Font-Bold="true" runat="server" Text=""></asp:Label><br />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnAddNewCon" EventName="Click" />
                                </Triggers>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                <ContentTemplate>
                                    <br />
                                    <asp:Button ID="btnResetCond" runat="server" Text="Reset Condition" CssClass="btn btn-primary"
                                        OnClick="btnResetCond_Click" />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnAddNewCon" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>--%>
                        </div>
    
                        <div class="col-md-4">
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label15" Text="Ordre par" Font-Bold="true" runat="server"></asp:Label></legend>
                                <asp:UpdatePanel ID="UpdatePanel21" runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBoxList ID="OrderbyList" runat="server" CssClass="form-control" Height="120px"
                                            SelectionMode="Multiple" Style="overflow: scroll;">
                                        </asp:CheckBoxList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cmbTable" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </fieldset>
                        </div>
    
                        <div class="col-md-2">
                            <fieldset class="scheduler-border" style="background-color: #F6F6F6">
                                <legend class="scheduler-border">
                                    <asp:Label ID="Label16" Text="Trier par" Font-Bold="true" runat="server"></asp:Label></legend>
                                <asp:DropDownList ID="orderbyMethod" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Ascending">Ascendant</asp:ListItem>
                                    <asp:ListItem Value="Descending">Descendant</asp:ListItem>
                                </asp:DropDownList>
                            </fieldset>
                        </div>

                        <div class="col-md-4">
                            <%--<asp:Button ID="btngenerate" runat="server" Style="margin: 10px;" Text="Générer la requête" CssClass="btn btn-primary"
                                OnClick="btngenerate_Click" />
                            <asp:Button ID="btnReset" runat="server" Text="Reset All" CssClass="btn btn-warning"
                                OnClick="btnReset_Click" />--%>
                        </div>

    
                        <%--<div class="clearfix">
                        </div>--%>
                        <%--<div class="col-md-9 mt-5 mb-5">
                            <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="SQLQueryText" Text="Code SQL" runat="server" Width="100%" CssClass="form-control" TextMode="MultiLine" Height="98px"></asp:TextBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btngenerate" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click"></asp:AsyncPostBackTrigger>
                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click"></asp:AsyncPostBackTrigger>
                                </Triggers>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>--%>
                        <%--<div class="col-md-1 mt-10">
                            <asp:Button ID="btngenerate" runat="server" Text="Générer la requête" CssClass="btn btn-info"
                                OnClick="btngenerate_Click" />
                        </div>--%>
                        <%--<div class="col-md-1 mt-10" style="margin-left: 66px;">
                            <asp:Button ID="btnRunQuery" Text="Exécuter la requête" runat="server" CssClass="btn btn-success"
                                OnClick="btnRunQuery_Click" />
                        </div>--%>
    
                        <%--<div class="clearfix">
                        </div>
                        <div class="col-md-1 mt-10">
                            <asp:Button ID="btnReset" runat="server" Text="Reset All" CssClass="btn btn-warning"
                                OnClick="btnReset_Click" />
                        </div>--%>
                        <%--<div class="col-md-1 mt-10">
                            <asp:Button ID="btnEdit" Text="Edit Query" runat="server" CssClass="btn btn-info"
                                OnClick="btnEdit_Click" />
                        </div>--%>
   
                        <div class="clearfix">
                        </div>
                        <div class="col-md-12 mt-10">
                            <asp:UpdatePanel ID="UpdatePanel20" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btngenerate" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
    
                        <%--<div class="clearfix">
                        </div>
                        <div class="col-md-12 mt-10">
                            <asp:UpdatePanel ID="UpdatePanel16" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="ResultGrid" runat="server" Class="table table-bordered table-hover table-struped"
                                        AllowPaging="true" PageSize="10" OnPageIndexChanging="OnPageIndexChanging" Style="overflow-x: auto;">
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnRunQuery" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>--%>
                        <%--<div class="col-md-2">
                            <asp:Button ID="btnExportExl" Text="Export Excel" runat="server" CssClass="btn btn-success"
                                OnClick="btnExportExl_Click" />
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnExpoPdf" Text="Export PDF" runat="server" CssClass="btn btn-success"
                                OnClick="btnExpoPdf_Click" Style="margin-left: -65px;" />
                        </div>--%>

                        <%--<div>
                            <asp:Menu ID="menu1" Orientation="Horizontal" StaticMenuItemStyle-CssClass="tab" Font-Size="Large" 
                                StaticSelectedStyle-CssClass="selectedTab" StaticMenuItemStyle-HorizontalPadding="50px" StaticHoverStyle-BackColor="White"
                                CssClass="tabs" runat="server">

                                <Items>
                                    <asp:MenuItem Text="SQL" Selected="true" Value="0"></asp:MenuItem>
                                    <asp:MenuItem Text="Result" Value="1"></asp:MenuItem>
                                </Items>
                            </asp:Menu>

                            <div class="tabContents">

                                    <asp:MultiView ID="Multiview1" ActiveViewIndex="0" runat="server">
                                        <asp:View ID="View1" runat ="server">
                                            <br /> hhhhhh
                                        </asp:View>
                                        <asp:View ID="View2" runat ="server">
                                            <br /> ayoub
                                        </asp:View>
                                    </asp:MultiView>

                                </div>

        
                        </div>--%>

                        <div class="clearfix">
                        </div>

                        <%--<div class="col-md-12 mt-10">
                            <div class="panel panel-default" style="background-color: #F6F6F6">
                                <div id="Tabs" role="tabpanel">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li><a href="#SQLQueryText1" aria-controls="SQLQueryText1" role="tab" data-toggle="tab">Requête SQL
                                        </a></li>
                                        <asp:Button ID="btnEdit" Text="Edit Query" Style="margin: 5px;" runat="server" CssClass="btn btn-primary" OnClick="btnEdit_Click" />
                                    </ul>
                                    <!-- Tab panes -->
                                    <div class="tab-content">
                                        <div role="tabpanel" class="tab-pane active" id="SQLQueryText1">
                                            <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="SQLQueryText" Style="margin: 10px;" Text="Code SQL" runat="server" Width="95%" CssClass="form-control" TextMode="MultiLine" Height="98px"></asp:TextBox>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="btngenerate" EventName="Click" />
                                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click"></asp:AsyncPostBackTrigger>
                                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click"></asp:AsyncPostBackTrigger>
                                                </Triggers>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                            
                                        </div>
                   
                                        <asp:HiddenField ID="TabName" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>--%>
        
                    </div>
                    
                    <div role="tabpanel" class="tab-pane" id="SQLQueryText1">
                       
                            <asp:UpdatePanel ID="UpdatePanel15" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="SQLQueryText" Style="background-color: #F6F6F6;margin: 10px;" Width="95%" Text="Code SQL" runat="server"  CssClass="form-control" TextMode="MultiLine" Height="98px"></asp:TextBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btngenerate" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click"></asp:AsyncPostBackTrigger>
                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click"></asp:AsyncPostBackTrigger>
                                </Triggers>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>

                           <asp:Button ID="btnEdit" Text="Edit Query" Style="margin: 10px;" runat="server" CssClass="btn btn-primary" OnClick="btnEdit_Click" />    

                    </div>

                    <div role="tabpanel" class="tab-pane" id="results">
                       <div class="col-md-12 mt-10">
                           <asp:Button ID="btnExpoPdf" Text="Export PDF" Style="margin: 5px; "  runat="server" CssClass="btn btn-info" OnClick="btnExpoPdf_Click" />
                            <asp:Button ID="btnExportExl" Text="Export Excel" runat="server" CssClass="btn btn-info" OnClick="btnExportExl_Click" />
                            <asp:UpdatePanel ID="UpdatePanel19" runat="server">
                                <ContentTemplate>
                               
                                    <asp:GridView ID="ResultGrid" runat="server" Style="overflow-x: auto; background-color: #F6F6F6"
                                                  Class="table table-bordered table-hover table-struped"
                                                  AllowPaging="true" PageSize="10" OnPageIndexChanging="OnPageIndexChanging">
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnRunQuery" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                            
                       </div>
                   </div>
                <asp:HiddenField ID="TabName" runat="server" />
            </div>
            </div>
        </div>

    </div>
    


    <script type="text/javascript">
        $(function () {
            var tabName = $("[id*=TabName]").val() != "" ? $("[id*=TabName]").val() : "generateur";
            $('#Tabs1 a[href="#' + tabName + '"]').tab('show');
            $("#Tabs1 a").click(function () {
                $("[id*=TabName]").val($(this).attr("href").replace("#", ""));
            });
        });
    </script>

    <script type="text/javascript">
        $(function () {
            $('#<%= btnRunQuery.ClientID %>').click(function () {
                $('.nav-tabs > .active').next('li').find('a').trigger('click');
            });
        });
    </script>
    
    <script type="text/javascript">
        $(function () {
            $('#<%= btngenerate.ClientID %>').click(function () {
                $('.nav-tabs > .active').next('li').find('a').trigger('click');
            });
        });
    </script>


</asp:Content>


