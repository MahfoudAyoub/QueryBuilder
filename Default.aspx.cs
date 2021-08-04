using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using CodeEngine.Framework.QueryBuilder;
using WebBasedQueryBuilder;
using System.Data.Common;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Xml;
using System.Text;
using System.Configuration;
using System.Drawing;

namespace DynamicSQLQuery
{
    public partial class _Default : Page
    {

        string viewName;
        SelectQueryBuilder queryBuilder;
        List<string> selectionPara;
        List<string> selectedTbl;
        List<string> selectedTblRelPara;
        List<string> joinSelectionPara;
        List<string> relationPara;
        List<string> wherePara;
        List<string> relationTbl;
        List<string> relationClmn;
        List<string> baseTblClmn;
        List<string> filedSelectionPara;
        List<string> conditionalOpPara;
        List<string> txtValuesPara;
        List<Int32> ConditionPara;
        List<string[]> betweenPara;
        List<string[]> inPara;
        List<CodeEngine.Framework.QueryBuilder.Enums.Comparison> fieldSelComp = new List<CodeEngine.Framework.QueryBuilder.Enums.Comparison>();
        CodeEngine.Framework.QueryBuilder.Enums.Sorting orderbyPara;

        public _Default()
        {
            _QueryBuilder = this;
        }
        public static _Default _QueryBuilder;

        protected void Page_Load(object sender, EventArgs e)
        {
            _QueryBuilder = new _Default();
            _QueryBuilder = this;
            SQLQueryText.Enabled = false;
            SetNewInstance();

            if (this.IsPostBack)
            {
                TabName.Value = Request.Form[TabName.UniqueID];
            } 

            else if (!IsPostBack)
            {
                LoadTable();
                ckSelectAllBase.Visible = false;
                ckSelectAllRel.Visible = false;
                btnResetCond.Visible = false;
                btnResetRel.Visible = false;
                //btnExportExl.Visible = false;
                //btnExpoPdf.Visible = false;
            }


        }
        private void SetNewInstance()
        {
            queryBuilder = new SelectQueryBuilder();
            selectionPara = new List<string>();
            selectedTbl = new List<string>();
            selectedTblRelPara = new List<string>();
            joinSelectionPara = new List<string>();
            relationPara = new List<string>();
            wherePara = new List<string>();
            relationTbl = new List<string>();
            relationClmn = new List<string>();
            baseTblClmn = new List<string>();
            filedSelectionPara = new List<string>();
            conditionalOpPara = new List<string>();
            txtValuesPara = new List<string>();
            ConditionPara = new List<Int32>();
            betweenPara = new List<string[]>();
            fieldSelComp = new List<CodeEngine.Framework.QueryBuilder.Enums.Comparison>();
            orderbyPara = new CodeEngine.Framework.QueryBuilder.Enums.Sorting();
            inPara = new List<string[]>();
            if (ViewState["relationPara"] != null)
            {
                relationPara = (List<string>)ViewState["relationPara"];
            }
            if (ViewState["relationTbl"] != null)
            {
                relationTbl = (List<string>)ViewState["relationTbl"];

            }
            if (ViewState["relationClmn"] != null)
            {
                relationClmn = (List<string>)ViewState["relationClmn"];
            }
            if (ViewState["baseTblClmn"] != null)
            {
                baseTblClmn = (List<string>)ViewState["baseTblClmn"];
            }
            if (ViewState["joinSelectionPara"] != null)
            {
                joinSelectionPara = (List<string>)ViewState["joinSelectionPara"];
            }
            if (ViewState["selectedTbl"] != null)
            {
                selectedTbl = (List<string>)ViewState["selectedTbl"];
            }
            if (ViewState["selectedTblRelPara"] != null)
            {
                selectedTblRelPara = (List<string>)ViewState["selectedTblRelPara"];
            }
            if (ViewState["filedSelectionPara"] != null)
            {
                filedSelectionPara = (List<string>)ViewState["filedSelectionPara"];
            }
            if (ViewState["conditionalOpPara"] != null)
            {
                conditionalOpPara = (List<string>)ViewState["conditionalOpPara"];
            }
            if (ViewState["txtValuesPara"] != null)
            {
                txtValuesPara = (List<string>)ViewState["txtValuesPara"];
            }
            if (ViewState["ConditionPara"] != null)
            {
                ConditionPara = (List<Int32>)ViewState["ConditionPara"];
            }
            if (ViewState["wherePara"] != null)
            {
                wherePara = (List<string>)ViewState["wherePara"];
            }
        }
        public _Default(string vName)
        {
            viewName = vName;
        }



        public List<string> TableNameList;

        private string _connectionString;

        private string _user = "";
        private string _password = "";
        private string _server = "";
        private string _schema = "";
        public string ConnectionString
        {
            get
            {
                if (string.IsNullOrWhiteSpace(_connectionString))
                {
                    if (_user != "" && _password != "" && _server != "" && _schema != "")
                    {
                        _connectionString = string.Format("Data Source={0};Initial Catalog={1};user id={2};password={3};Integrated Security=false;", _server, _schema, _user, _password);
                    }
                    else if (_user != "" && _password != "" && _server != "")
                    {
                        _connectionString = string.Format("Data Source={0};Initial Catalog={1};user id={2};password={3};Integrated Security=false;", _server, "master", _user, _password);
                    }
                    else
                    {
                        if (_server != "" && _schema != "")
                        {

                            _connectionString = string.Format("Data Source={0};Initial Catalog={1};Trusted_Connection=true;", _server, _schema);
                        }
                        else
                        {

                            _connectionString = string.Format("Data Source={0};Initial Catalog={1};Trusted_Connection=true;", ".", "master");
                        }
                    }

                }
                return _connectionString;
            }
        }
        protected void LoadTable()
        {

            TableNameList = new List<string>();
            string ConString = ConnectionString;// ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            Session["Connection_String"] = ConString;
            SqlConnection con = new SqlConnection(ConString);
            SqlCommand command = con.CreateCommand();
            con.Open();
            DataTable dtable = con.GetSchema("Tables");
            foreach (DataRow row in dtable.Rows)
            {
                string tablename = (string)row[2];
                TableNameList.Add(tablename);
            }
            TableNameList.Sort();
            cmbTable.DataSource = null;
            cmbTable.DataSource = TableNameList;
            cmbTable.DataBind();
            cmbTable.Items.Insert(0, "Select");

            cmbRlTable.DataSource = null;
            cmbRlTable.DataSource = TableNameList;
            cmbRlTable.DataBind();
            cmbRlTable.Items.Insert(0, "Select");
            con.Close();

        }
        string selectTable = "";
        
        protected void CmbTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbTable.SelectedIndex != 0)
            {
                try
                {

                    selectTable = cmbTable.SelectedItem.ToString();
                    Session["selected_table"] = selectTable;
                    ViewState["selectedTbl"] = null;
                    selectedTbl.Clear();
                    selectedTbl.Add(selectTable);
                    ViewState["selectedTbl"] = selectedTbl;

                    string sqlQuery = "Select * from " + selectTable;
                    SqlCommand command = new SqlCommand(sqlQuery);
                    SqlConnection sqlConn = new SqlConnection((Session["Connection_String"]).ToString());
                    sqlConn.Open();
                    command.Connection = sqlConn;
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    sqlConn.Close();
                    List<string> columnNames = new List<string>();
                    List<string> numerticCol = new List<string>();

                    foreach (DataColumn column in dt.Columns)
                    {
                        columnNames.Add(column.ColumnName);
                        if (column.DataType == System.Type.GetType("System.Int32"))
                        {
                            numerticCol.Add(column.ColumnName);
                        }
                    }
                    FieldNameList.DataSource = columnNames;
                    FieldNameList.DataBind();
                    ckSelectAllBase.Checked = false;
                    ckSelectAllBase.Visible = true;
                    LoadSelectedTable();
                    OrderbyList.DataSource = columnNames;
                    OrderbyList.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.ToString();

                }
            }
            else
            {
                ckSelectAllBase.Visible = false;
                FieldNameList.Items.Clear();
                joinSelectedTable.Items.Clear();
                OrderbyList.Items.Clear();
            }
        }

        private void LoadSelectedTable()
        {
            if (ViewState["selectedTbl"] != null)
            {
                joinSelectedTable.DataSource = (List<string>)ViewState["selectedTbl"];
                joinSelectedTable.DataBind();
                joinSelectedTable.Items.Insert(0, "Select");
                cmbBaseTblClmn.Items.Clear();

                conditionTbl.DataSource = (List<string>)ViewState["selectedTbl"];
                conditionTbl.DataBind();
                conditionTbl.Items.Insert(0, "Select");
                conditionTblClm.Items.Clear();
            }
        }

        protected void CmbRlTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbRlTable.SelectedIndex != 0)
            {
                try
                {

                    selectTable = cmbRlTable.SelectedItem.ToString();
                    Session["selectedRlton_table"] = selectTable;
                    string sqlQuery = "Select * from " + selectTable;
                    SqlCommand command = new SqlCommand(sqlQuery);
                    SqlConnection sqlConn = new SqlConnection((Session["Connection_String"]).ToString());
                    sqlConn.Open();
                    command.Connection = sqlConn;
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    sqlConn.Close();
                    List<string> columnNames = new List<string>();
                    List<string> numerticCol = new List<string>();

                    foreach (DataColumn column in dt.Columns)
                    {
                        columnNames.Add(column.ColumnName);
                        if (column.DataType == System.Type.GetType("System.Int32"))
                        {
                            numerticCol.Add(column.ColumnName);
                        }
                    }
                    RelationFieldNameList.DataSource = columnNames;
                    RelationFieldNameList.DataBind();

                    cmbRlColumn.DataSource = null;
                    cmbRlColumn.DataSource = columnNames;
                    cmbRlColumn.DataBind();
                    ckSelectAllRel.Checked = false;
                    ckSelectAllRel.Visible = true;


                }
                catch (Exception ex)
                {
                    lblError.Text = ex.ToString();

                }
            }
            else
            {
                ckSelectAllRel.Visible = false;
                RelationFieldNameList.Items.Clear();
                cmbRlColumn.Items.Clear();
            }
        }

        protected void ckSelectAllBase_CheckChanged(object sender, EventArgs e)
        {
            if (ckSelectAllBase.Checked)
            {
                for (int i = 0; i < FieldNameList.Items.Count; i++)
                {
                    FieldNameList.Items[i].Selected = true;
                }
            }
            else
            {
                for (int i = 0; i < FieldNameList.Items.Count; i++)
                {
                    FieldNameList.Items[i].Selected = false;
                }
            }

        }
        
        protected void ckSelectAllRel_CheckChanged(object sender, EventArgs e)
        {
            if (ckSelectAllRel.Checked)
            {
                for (int i = 0; i < RelationFieldNameList.Items.Count; i++)
                {
                    RelationFieldNameList.Items[i].Selected = true;
                }
            }
            else
            {
                for (int i = 0; i < RelationFieldNameList.Items.Count; i++)
                {
                    RelationFieldNameList.Items[i].Selected = false;
                }
            }

        }

        protected void JoinSelectedTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (joinSelectedTable.SelectedIndex != 0)
            {
                try
                {

                    selectTable = joinSelectedTable.SelectedItem.ToString();
                    string sqlQuery = "Select * from " + selectTable;
                    SqlCommand command = new SqlCommand(sqlQuery);
                    SqlConnection sqlConn = new SqlConnection((Session["Connection_String"]).ToString());
                    sqlConn.Open();
                    command.Connection = sqlConn;
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    sqlConn.Close();
                    List<string> columnNames = new List<string>();
                    List<string> numerticCol = new List<string>();

                    foreach (DataColumn column in dt.Columns)
                    {
                        columnNames.Add(column.ColumnName);
                    }
                    cmbBaseTblClmn.Items.Clear();
                    cmbBaseTblClmn.DataSource = columnNames;
                    cmbBaseTblClmn.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.ToString();

                }
            }
            else
            {
                cmbBaseTblClmn.Items.Clear();
            }
        }

        protected void conditionTbl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (conditionTbl.SelectedIndex != 0)
            {
                try
                {

                    selectTable = conditionTbl.SelectedItem.ToString();
                    string sqlQuery = "Select * from " + selectTable;
                    SqlCommand command = new SqlCommand(sqlQuery);
                    SqlConnection sqlConn = new SqlConnection((Session["Connection_String"]).ToString());
                    sqlConn.Open();
                    command.Connection = sqlConn;
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    sqlConn.Close();
                    List<string> columnNames = new List<string>();
                    List<string> numerticCol = new List<string>();

                    foreach (DataColumn column in dt.Columns)
                    {
                        columnNames.Add(column.ColumnName);
                    }
                    conditionTblClm.Items.Clear();
                    conditionTblClm.DataSource = columnNames;
                    conditionTblClm.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.ToString();

                }
            }
            else
            {
                conditionTblClm.Items.Clear();
            }
        }

        protected void btnAddJoin_Click(object sender, EventArgs e)
        {
            if (cmbRlTable.SelectedIndex != 0)
            {
                string rlTableName = cmbRlTable.SelectedItem.ToString();
                for (int i = 0; i < RelationFieldNameList.Items.Count; i++)
                {
                    if (RelationFieldNameList.Items[i].Selected)
                    {
                        joinSelectionPara.Add("[" + rlTableName + "]" + "." + "[" + RelationFieldNameList.Items[i].ToString() + "]");
                    }

                }
            }
            selectedTblRelPara.Add(joinSelectedTable.SelectedItem.ToString());
            ViewState["selectedTblRelPara"] = selectedTblRelPara;
            selectedTbl.Add(cmbRlTable.SelectedItem.ToString());
            ViewState["selectedTbl"] = selectedTbl;
            ViewState["joinSelectionPara"] = joinSelectionPara;
            baseTblClmn.Add(cmbBaseTblClmn.SelectedItem.ToString());
            ViewState["baseTblClmn"] = baseTblClmn;
            relationTbl.Add(cmbRlTable.SelectedItem.ToString());
            ViewState["relationTbl"] = relationTbl;
            relationClmn.Add(cmbRlColumn.SelectedItem.ToString());
            ViewState["relationClmn"] = relationClmn;
            relationPara.Add("JOIN " + cmbRlColumn.SelectedItem.ToString() + " FROM " + cmbRlTable.SelectedItem.ToString() + " ON " + cmbBaseTblClmn.SelectedItem.ToString() + " FROM " + joinSelectedTable.SelectedItem.ToString());
            string joinStr = "";
            ViewState["relationPara"] = relationPara;
            foreach (string str in relationPara)
            {
                joinStr += str + "<br/>";
            }
            lblJoin.Text = joinStr;
            LoadSelectedTable();
            btnResetRel.Visible = true;

            cmbRlTable.SelectedIndex = 0;
            cmbRlColumn.Items.Clear();
            joinSelectedTable.SelectedIndex = 0;
            cmbBaseTblClmn.Items.Clear();
            RelationFieldNameList.Items.Clear();
            ckSelectAllRel.Visible = false;
        }

        protected void btnAddCondition_Click(object sender, EventArgs e)
        {
            int count = 1;
            if (ViewState["count"] != null)
            {
                count = (int)ViewState["count"];
            }
            string tableName = conditionTbl.SelectedItem.ToString();

            if (conditionTblClm.SelectedItem.ToString() != "")
            {
                if (conditionTblClm.SelectedItem.ToString() != "Select")
                    filedSelectionPara.Add("[" + tableName + "].[" + conditionTblClm.SelectedItem.ToString() + "]");
                ViewState["filedSelectionPara"] = filedSelectionPara;
            }
            if (conditionalOpCB.SelectedItem.ToString() != "")
            {
                if (conditionalOpCB.SelectedItem.ToString() != "Select")
                    conditionalOpPara.Add(conditionalOpCB.SelectedItem.ToString());
                ViewState["conditionalOpPara"] = conditionalOpPara;
            }
            if (txtValues.Text != "")
            {
                txtValuesPara.Add(txtValues.Text);
                ViewState["txtValuesPara"] = txtValuesPara;
            }


            if (conditionAndOr.SelectedItem.ToString() == "OR")
            {
                ConditionPara.Add(count);
                count++;
            }
            else
            {
                ConditionPara.Add(count);
            }
            ViewState["count"] = count;
            ViewState["ConditionPara"] = ConditionPara;


            string andOr = "";
            if (conditionAndOr.SelectedItem.ToString() == "OR")
            {
                ViewState["AndOr"] = "OR";
            }
            if (conditionAndOr.SelectedItem.ToString() == "AND")
            {
                ViewState["AndOr"] = "AND";
            }
            if (ViewState["AndOr"] != null)
            {
                andOr = ViewState["AndOr"].ToString();
            }
            wherePara.Add("WHERE " + conditionTblClm.SelectedItem.ToString() + " " + conditionalOpCB.SelectedItem.ToString() + " " + txtValues.Text + " " + andOr);
            string joinStr = "";
            ViewState["wherePara"] = wherePara;
            foreach (string str in wherePara)
            {
                joinStr += str + " ";
            }
            lblWhereTxt.Text = joinStr;
            ViewState["AndOr"] = null;
            btnResetCond.Visible = true;

            conditionTbl.SelectedIndex = 0;
            conditionTblClm.Items.Clear();
            conditionalOpCB.SelectedIndex = 0;
            txtValues.Text = "";
            conditionAndOr.SelectedIndex = 0;

        }

        protected void btnResetRel_Click(object sender, EventArgs e)
        {
            ViewState["relationPara"] = null;
            ViewState["relationTbl"] = null;
            ViewState["relationClmn"] = null;
            ViewState["baseTblClmn"] = null;
            ViewState["joinSelectionPara"] = null;
            ViewState["selectedTblRelPara"] = null;
            lblJoin.Text = "";
            cmbRlTable.SelectedIndex = 0;
            RelationFieldNameList.Items.Clear();
            cmbRlColumn.Items.Clear();
            ckSelectAllRel.Visible = false;
            btnExportExl.Visible = false;
            btnExpoPdf.Visible = false;

            selectTable = cmbTable.SelectedItem.ToString();
            ViewState["selectedTbl"] = null;
            selectedTbl.Clear();
            selectedTbl.Add(selectTable);
            ViewState["selectedTbl"] = selectedTbl;
            LoadSelectedTable();
            btnResetRel.Visible = false;
        }
        
        protected void btnResetCond_Click(object sender, EventArgs e)
        {
            ViewState["count"] = null;
            ViewState["filedSelectionPara"] = null;
            ViewState["conditionalOpPara"] = null;
            ViewState["txtValuesPara"] = null;
            ViewState["ConditionPara"] = null;
            ViewState["wherePara"] = null;
            lblWhereTxt.Text = "";
            btnResetCond.Visible = false;
            conditionTbl.SelectedIndex = 0;
            conditionTblClm.Items.Clear();
            conditionalOpCB.SelectedIndex = 0;
            txtValues.Text = "";
            conditionAndOr.SelectedIndex = 0;
        }

        protected void conditionalOpCB_SelectionChanged(object sender, EventArgs e)
        {
            if (conditionalOpCB.SelectedItem.ToString() == "BETWEEN" || conditionalOpCB.SelectedItem.ToString() == "IN" || conditionalOpCB.SelectedItem.ToString() == "Not IN")
            {
                txtValues.Attributes.Add("Placeholder", "Value1,Value2");
            }
            else
            {
                txtValues.Attributes.Add("Placeholder", "");
            }


        }
        
        protected void btngenerate_Click(object sender, EventArgs e)
        {
            ViewState["count"] = null;
            if (cmbTable.SelectedIndex != 0)
            {
                string tableName = Session["selected_table"].ToString();
                for (int i = 0; i < FieldNameList.Items.Count; i++)
                {
                    if (FieldNameList.Items[i].Selected)
                    {
                        selectionPara.Add("[" + tableName + "]" + "." + "[" + FieldNameList.Items[i].ToString() + "]");
                    }
                }



                CodeEngine.Framework.QueryBuilder.SelectQueryBuilder queryBuilder = new SelectQueryBuilder();
                queryBuilder.SelectFromTable((Session["selected_table"]).ToString());
                for (int i = 0; i < joinSelectionPara.Count; i++)
                {
                    selectionPara.Add(joinSelectionPara[i]);
                }
                for (int i = 0; i < relationPara.Count; i++)
                {

                    queryBuilder.AddJoin(CodeEngine.Framework.QueryBuilder.Enums.JoinType.InnerJoin, relationTbl[i], relationClmn[i], CodeEngine.Framework.QueryBuilder.Enums.Comparison.Equals, selectedTblRelPara[i], baseTblClmn[i]);
                }

                selectionPara.ToArray();
                queryBuilder.SelectColumns(selectionPara.ToArray());

                int count = 0;
                foreach (string conVal in conditionalOpPara)
                {
                    if (conVal == "Equals")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.Equals);
                    if (conVal == "Not Equals")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.NotEquals);
                    if (conVal == "Less Than")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.LessThan);
                    if (conVal == "Less Or Equals")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.LessOrEquals);
                    if (conVal == "Greater Than")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.GreaterThan);
                    if (conVal == "Greater Or Equals")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.GreaterOrEquals);
                    if (conVal == "LIKE")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.Like);
                    if (conVal == "Not LIKE")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.NotLike);
                    if (conVal == "Start With")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.Like);
                    if (conVal == "End With")
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.Like);
                    if (conVal == "IN")
                    {
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.In);
                        inPara.Add(txtValuesPara[count].Split(','));
                    }
                    if (conVal == "Not IN")
                    {
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.NotIn);
                        inPara.Add(txtValuesPara[count].Split(','));
                    }
                    if (conVal == "BETWEEN")
                    {
                        fieldSelComp.Add(CodeEngine.Framework.QueryBuilder.Enums.Comparison.Between);
                        betweenPara.Add(txtValuesPara[count].Split(','));
                    }
                    count++;
                }

                count = 0;
                for (int i = 0; i < fieldSelComp.Count; i++)
                {
                    if (fieldSelComp.Count > 0)
                    {
                        if (fieldSelComp[i] == CodeEngine.Framework.QueryBuilder.Enums.Comparison.Between)
                        {
                            queryBuilder.AddWhere(filedSelectionPara[i], fieldSelComp[i], betweenPara[count], ConditionPara[i]);
                            count++;
                        }
                        else if (fieldSelComp[i] == CodeEngine.Framework.QueryBuilder.Enums.Comparison.Like)
                        {
                            queryBuilder.AddWhere(filedSelectionPara[i], fieldSelComp[i], txtValuesPara[i], ConditionPara[i]);
                            count++;
                        }

                        else if (fieldSelComp[i] == CodeEngine.Framework.QueryBuilder.Enums.Comparison.NotLike)
                        {
                            queryBuilder.AddWhere(filedSelectionPara[i], fieldSelComp[i], "%" + txtValuesPara[i] + "%", ConditionPara[i]);
                            count++;
                        }

                        else if (fieldSelComp[i] == CodeEngine.Framework.QueryBuilder.Enums.Comparison.In)
                        {
                            queryBuilder.AddWhere(filedSelectionPara[i], CodeEngine.Framework.QueryBuilder.Enums.Comparison.In, inPara[count], ConditionPara[i]);
                        }
                        else if (fieldSelComp[i] == CodeEngine.Framework.QueryBuilder.Enums.Comparison.NotIn)
                        {
                            queryBuilder.AddWhere(filedSelectionPara[i], CodeEngine.Framework.QueryBuilder.Enums.Comparison.NotIn, inPara[count], ConditionPara[i]);
                        }
                        else
                        {
                            queryBuilder.AddWhere(filedSelectionPara[i], fieldSelComp[i], txtValuesPara[i], ConditionPara[i]);
                        }
                    }
                }
                if (orderbyMethod.Text == "Ascending")
                    orderbyPara = CodeEngine.Framework.QueryBuilder.Enums.Sorting.Ascending;
                else
                    orderbyPara = CodeEngine.Framework.QueryBuilder.Enums.Sorting.Descending;
                for (int i = 0; i < OrderbyList.Items.Count; i++)
                {
                    if (OrderbyList.Items[i].Selected)
                    {
                        queryBuilder.AddOrderBy(OrderbyList.Items[i].ToString(), orderbyPara);

                    }
                }

                queryBuilder.SetDbProviderFactory(DbProviderFactories.GetFactory("System.Data.SqlClient"));

                /// Build Final query result
                SQLQueryText.Text = queryBuilder.BuildQuery();
                SqlConnection sqlConn;
                try
                {
                    SqlCommand command = new SqlCommand(SQLQueryText.Text);
                    sqlConn = sqlConn = new SqlConnection((Session["Connection_String"]).ToString());
                    sqlConn.Open();
                    command.Connection = sqlConn;
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    sqlConn.Close();
                    // SetNewInstance();

                }
                catch (SqlException ex)
                {
                    this.Session["exceptionMessage"] = ex.Message;
                    //   Response.Redirect("ErrorDisplay.aspx");
                    lblError.Text = ex.Message;
                    //       log.Write(ex.Message + ex.StackTrace);

                }
                sqlConn = null;


                //   SetNewInstance();
            }
        }

        DataTable dt;
        
        protected void btnRunQuery_Click(object sender, EventArgs e)
        {

            if (SQLQueryText.Enabled == true)
            {
                SQLQueryText.Enabled = false;
            }
            //   expResult.IsExpanded = true;
            SqlConnection sqlConn;
            try
            {
                SqlCommand command = new SqlCommand(SQLQueryText.Text);
                sqlConn = new SqlConnection((Session["Connection_String"]).ToString());
                sqlConn.Open();
                command.Connection = sqlConn;
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                dt = new DataTable();
                adapter.Fill(dt);
                //resultTable.Visible = true;
                lblError.Text = null;
                btnExportExl.Visible = true;
                btnExpoPdf.Visible = true;
                ResultGrid.DataSource = dt.DefaultView;
                ResultGrid.DataBind();
                sqlConn.Close();
                Session["SelectedData"] = dt;
                if (dt.Rows.Count < 1)
                {
                    Session["SelectedData"] = null;
                    lblError.Text = "No Record Found !";
                }
            }
            catch (SqlException ex)
            {
                lblError.Text = ex.ToString();
            }

            sqlConn = null;
        }
        
        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ResultGrid.PageIndex = e.NewPageIndex;
            DataTable dt = (DataTable)Session["SelectedData"];
            ResultGrid.DataSource = dt.DefaultView;
            ResultGrid.DataBind();
            //btnExportExcel.Visible = true;
            //btnExportPDF.Visible = true;
        }

        protected void GridView_PreRender(object sender, EventArgs e)
        {
            GridView gv = (GridView)sender;

            if ((gv.ShowHeader == true && gv.Rows.Count > 0)
                || (gv.ShowHeaderWhenEmpty == true))
            {
                //Force GridView to use <thead> instead of <tbody> - 11/03/2013 - MCR.
                gv.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            if (gv.ShowFooter == true && gv.Rows.Count > 0)
            {
                //Force GridView to use <tfoot> instead of <tbody> - 11/03/2013 - MCR.
                gv.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {

            ViewState["relationPara"] = null;
            ViewState["relationTbl"] = null;
            ViewState["relationClmn"] = null;
            ViewState["baseTblClmn"] = null;
            ViewState["joinSelectionPara"] = null;
            ViewState["selectedTbl"] = null;
            ViewState["selectedTblRelPara"] = null;
            lblJoin.Text = "";
            cmbRlTable.SelectedIndex = 0;
            cmbTable.SelectedIndex = 0;
            cmbBaseTblClmn.Items.Clear();
            RelationFieldNameList.Items.Clear();
            cmbRlColumn.Items.Clear();
            joinSelectedTable.Items.Clear();
            ckSelectAllBase.Visible = false;
            ckSelectAllRel.Visible = false;
            btnExportExl.Visible = false;
            btnExpoPdf.Visible = false;

            List<string> EMPTY = new List<string>();
            FieldNameList.ClearSelection();
            FieldNameList.DataSource = EMPTY;
            FieldNameList.DataBind();

            SQLQueryText.Enabled = true;
            SQLQueryText.Text = null;
            ResultGrid.DataSource = null;
            ResultGrid.DataBind();
            lblError.Text = "";

            ViewState["count"] = null;
            ViewState["filedSelectionPara"] = null;
            ViewState["conditionalOpPara"] = null;
            ViewState["txtValuesPara"] = null;
            ViewState["ConditionPara"] = null;
            ViewState["wherePara"] = null;
            lblWhereTxt.Text = "";
            btnResetCond.Visible = false;
            conditionTbl.Items.Clear();
            conditionTblClm.Items.Clear();
            conditionalOpCB.SelectedIndex = 0;
            txtValues.Text = "";
            conditionAndOr.SelectedIndex = 0;
            OrderbyList.Items.Clear();
            Session["SelectedData"] = null;


        }
        
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            SQLQueryText.Enabled = true;
        }

        protected void btnExpoPdf_Click(object sender, EventArgs e)
        {
            ExportGridToPDF();
        }
        
        protected void btnExportExl_Click(object sender, EventArgs e)
        {
            ExportGridToExcel();
        }

        private void ExportGridToPDF()
        {

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    //To Export all pages
                    ResultGrid.AllowPaging = false;

                    if (Session["SelectedData"] != null)
                    {
                        DataTable dt = (DataTable)Session["SelectedData"];
                        ResultGrid.DataSource = dt.DefaultView;
                        ResultGrid.DataBind();
                    }
                    else
                    {
                        return;
                    }
                    ResultGrid.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=" + Session["selected_table"].ToString() + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }

        private void ExportGridToExcel()
        {

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                ResultGrid.AllowPaging = false;
                if (Session["SelectedData"] != null)
                {
                    DataTable dt = (DataTable)Session["SelectedData"];
                    ResultGrid.DataSource = dt.DefaultView;
                    ResultGrid.DataBind();
                }
                else
                {
                    return;
                }
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=" + Session["selected_table"].ToString() + ".xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-excel";
                ResultGrid.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in ResultGrid.HeaderRow.Cells)
                {
                    cell.BackColor = ResultGrid.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in ResultGrid.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = ResultGrid.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = ResultGrid.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                ResultGrid.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }


        public override void VerifyRenderingInServerForm(Control control)
        {
            //required to avoid the runtime error "  
            //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
        }

        protected void btnConnect_Click(object sender, EventArgs e)
        {
            try
            {
                if (tbxServerName.Text == "")
                {
                    lblmsgcon.Text = "Please input server name.";
                    tbxServerName.Focus();
                    return;
                }

                _user = tbxUserId.Text.Trim();
                _password = tbxPassword.Text.Trim();
                _server = tbxServerName.Text.Trim();
                string ConString = ConnectionString;
                // String str = "Server=" + tbxServerName.Text.Trim() + ";Database=master;Trusted_Connection=true";

                String query = @"SELECT name from sys.databases";
                SqlConnection con = new SqlConnection(ConString);
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                DataSet ds = new DataSet();
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                adp.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblmsgcon.Text = "Connexion réussie.";
                    CmbDatabase.DataSource = ds.Tables[0];
                    CmbDatabase.DataTextField = "name";
                    CmbDatabase.DataValueField = "name";
                    CmbDatabase.DataBind();
                    //CmbDatabase.Items.Insert(0, "Select");
                }
                else
                { lblmsgcon.Text = "Connection failed!"; tbxServerName.Focus(); }
                con.Close();

                SqlCommand cmd7 = new SqlCommand(@"IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'BreakStringIntoRows' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'Function')
                                                      Drop FUNCTION dbo.BreakStringIntoRows", con);
                if (con.State == ConnectionState.Closed)

                    con.Open();
                cmd7.ExecuteNonQuery();
                con.Close();


                SqlCommand comd = new SqlCommand(@"IF NOT EXISTS
   (  SELECT [name] 
      FROM sys.tables
      WHERE [name] = 'MyTable' 
   )
   CREATE TABLE MyTable (servername nvarchar(50), DatabaseName nvarchar(50),backuptime nvarchar(200),location nvarchar(200),Alias nvarchar(200),FileFormat nvarchar(30),BackType nvarchar(30) )", con);
                if (con.State == ConnectionState.Closed)

                    con.Open();
                comd.ExecuteNonQuery();
                con.Close();



                SqlCommand cmd4 = new SqlCommand(@"CREATE  FUNCTION dbo.BreakStringIntoRows (@CommadelimitedString   varchar(1000))
RETURNS   @Result TABLE (Column1   VARCHAR(100))
AS
BEGIN
        DECLARE @IntLocation INT
        WHILE (CHARINDEX(',',    @CommadelimitedString, 0) > 0)
        BEGIN
              SET @IntLocation =   CHARINDEX(',',    @CommadelimitedString, 0)      
              INSERT INTO   @Result (Column1)
              --LTRIM and RTRIM to ensure blank spaces are   removed
              SELECT RTRIM(LTRIM(SUBSTRING(@CommadelimitedString,   0, @IntLocation)))   
              SET @CommadelimitedString = STUFF(@CommadelimitedString,   1, @IntLocation,   '') 
        END
        INSERT INTO   @Result (Column1)
        SELECT RTRIM(LTRIM(@CommadelimitedString))--LTRIM and RTRIM to ensure blank spaces are removed
        RETURN 
END", con);
                if (con.State == ConnectionState.Closed)

                    con.Open();
                cmd4.ExecuteNonQuery();
                con.Close();

            }

            catch (Exception es)
            {

                // MessageBox.Show(es.Message);
                lblmsgcon.Text = es.Message;


            }
            finally
            { CmbDatabase.Focus(); }
        }

        protected void CmbDatabase_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tbxServerName.Text == "")
            {
                lblmsgcon.Text = "Please input server name.";
                tbxServerName.Focus();
                return;
            }
            _server = tbxServerName.Text;
            _schema = CmbDatabase.SelectedValue;
            _user = tbxUserId.Text.Trim();
            _password = tbxPassword.Text.Trim();
            LoadTable();
        }

        protected void gvDistricts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowIndex == 0)
                    e.Row.Style.Add("height", "50px");
            }
        }
    }
}