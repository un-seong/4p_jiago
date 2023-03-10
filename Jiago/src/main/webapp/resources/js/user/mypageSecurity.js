const cpath = '/jiago'

const pwbtn = document.getElementById('pwbtn')
	
	
	
	function pwmodify(event) {
        var pwUrl = cpath + '/popUp/pwmodify';
        var pwOption = 'top=10, left=10, width=1000, height=600, status=no, menubar=no, toolbar=no, resizable=no';
        window.open(pwUrl, 'popUp', pwOption);
	}
	