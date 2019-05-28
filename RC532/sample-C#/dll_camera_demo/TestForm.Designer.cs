namespace dll_camera_demo
{
    partial class TestForm
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.buttonRead = new System.Windows.Forms.Button();
            this.Clear = new System.Windows.Forms.Button();
            this.qrDecode = new System.Windows.Forms.CheckBox();
            this.labelText = new System.Windows.Forms.Label();
            this.codeInfo = new System.Windows.Forms.TextBox();
            this.timerCheck = new System.Windows.Forms.Timer(this.components);
            this.dmDecode = new System.Windows.Forms.CheckBox();
            this.hxDecode = new System.Windows.Forms.CheckBox();
            this.barDecode = new System.Windows.Forms.CheckBox();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // buttonRead
            // 
            this.buttonRead.Location = new System.Drawing.Point(111, 318);
            this.buttonRead.Name = "buttonRead";
            this.buttonRead.Size = new System.Drawing.Size(75, 23);
            this.buttonRead.TabIndex = 0;
            this.buttonRead.Text = "获取解码信息";
            this.buttonRead.UseVisualStyleBackColor = true;
            this.buttonRead.Click += new System.EventHandler(this.buttonRead_Click);
            // 
            // Clear
            // 
            this.Clear.Location = new System.Drawing.Point(349, 317);
            this.Clear.Name = "Clear";
            this.Clear.Size = new System.Drawing.Size(75, 23);
            this.Clear.TabIndex = 1;
            this.Clear.Text = "清除";
            this.Clear.UseVisualStyleBackColor = true;
            this.Clear.Click += new System.EventHandler(this.Clear_Click);
            // 
            // qrDecode
            // 
            this.qrDecode.AutoSize = true;
            this.qrDecode.Location = new System.Drawing.Point(38, 13);
            this.qrDecode.Name = "qrDecode";
            this.qrDecode.Size = new System.Drawing.Size(36, 16);
            this.qrDecode.TabIndex = 2;
            this.qrDecode.Text = "QR";
            this.qrDecode.UseVisualStyleBackColor = true;
            this.qrDecode.CheckedChanged += new System.EventHandler(this.qrDecode_CheckedChanged);
            // 
            // labelText
            // 
            this.labelText.AutoSize = true;
            this.labelText.Location = new System.Drawing.Point(36, 65);
            this.labelText.Name = "labelText";
            this.labelText.Size = new System.Drawing.Size(95, 12);
            this.labelText.TabIndex = 3;
            this.labelText.Text = "MSG获取解码信息";
            // 
            // codeInfo
            // 
            this.codeInfo.Location = new System.Drawing.Point(38, 99);
            this.codeInfo.Multiline = true;
            this.codeInfo.Name = "codeInfo";
            this.codeInfo.Size = new System.Drawing.Size(303, 59);
            this.codeInfo.TabIndex = 4;
           
            // 
            // timerCheck
            // 
            this.timerCheck.Tick += new System.EventHandler(this.timerCheck_Tick);
            // 
            // dmDecode
            // 
            this.dmDecode.AutoSize = true;
            this.dmDecode.Location = new System.Drawing.Point(127, 13);
            this.dmDecode.Name = "dmDecode";
            this.dmDecode.Size = new System.Drawing.Size(36, 16);
            this.dmDecode.TabIndex = 5;
            this.dmDecode.Text = "DM";
            this.dmDecode.UseVisualStyleBackColor = true;
            this.dmDecode.CheckedChanged += new System.EventHandler(this.dmDecode_CheckedChanged);
            // 
            // hxDecode
            // 
            this.hxDecode.AutoSize = true;
            this.hxDecode.Location = new System.Drawing.Point(241, 12);
            this.hxDecode.Name = "hxDecode";
            this.hxDecode.Size = new System.Drawing.Size(36, 16);
            this.hxDecode.TabIndex = 6;
            this.hxDecode.Text = "HX";
            this.hxDecode.UseVisualStyleBackColor = true;
            this.hxDecode.CheckedChanged += new System.EventHandler(this.hxDecode_CheckedChanged);
            // 
            // barDecode
            // 
            this.barDecode.AutoSize = true;
            this.barDecode.Location = new System.Drawing.Point(327, 12);
            this.barDecode.Name = "barDecode";
            this.barDecode.Size = new System.Drawing.Size(66, 16);
            this.barDecode.TabIndex = 7;
            this.barDecode.Text = "BARCODE";
            this.barDecode.UseVisualStyleBackColor = true;
            this.barDecode.CheckedChanged += new System.EventHandler(this.barDecode_CheckedChanged);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(38, 188);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(303, 69);
            this.textBox1.TabIndex = 8;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(38, 165);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(101, 12);
            this.label1.TabIndex = 9;
            this.label1.Text = "函数获取解码信息";
            // 
            // TestForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(504, 386);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.barDecode);
            this.Controls.Add(this.hxDecode);
            this.Controls.Add(this.dmDecode);
            this.Controls.Add(this.codeInfo);
            this.Controls.Add(this.labelText);
            this.Controls.Add(this.qrDecode);
            this.Controls.Add(this.Clear);
            this.Controls.Add(this.buttonRead);
            this.Name = "TestForm";
            this.Text = "532Demo";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.TestForm_FormClosed);
            this.Load += new System.EventHandler(this.TestForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonRead;
        private System.Windows.Forms.Button Clear;
        private System.Windows.Forms.CheckBox qrDecode;
        private System.Windows.Forms.Label labelText;
        private System.Windows.Forms.TextBox codeInfo;
        private System.Windows.Forms.Timer timerCheck;
        private System.Windows.Forms.CheckBox dmDecode;
        private System.Windows.Forms.CheckBox hxDecode;
        private System.Windows.Forms.CheckBox barDecode;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label label1;
    }
}

