function deleteHandler(event) {
	
	const replyWriter = event.target.parentNode.parentNode.querySelector('.writer')
	console.log(login_user_id, replyWriter.innerText)
	
	if(login_user_id != replyWriter.innerText) {
		alert('본인이 작성한 댓글만 삭제할 수 있습니다')
		return
	}
	else {
		const flag = confirm('정말 삭제하시겠습니까?')
		if(flag) {
			const idx = replyWriter.parentNode.parentNode.parentNode.getAttribute('idx')
			const url = `${cpath}/board/reply/${qboard_idx}/${idx}`
			const opt = {
				method: 'DELETE'
			}
			fetch(url, opt)	
			location.reload()
		}
	}
}

async function replyLoadHandler() {
	const replyDiv = document.getElementById('reply')
	const url = cpath + '/board/reply/' + qboard_idx
	
	await fetch(url)
	.then(resp => resp.json())
	.then(json => {
		const arr = json
		replyDiv.innerHTML = ''
		
		arr.forEach(dto => {
			const html = convertHTMLfromJSON(dto)
			replyDiv.innerHTML += html
		})
	})
	const deleteBtnList = document.querySelectorAll('button.delete')
	deleteBtnList.forEach(btn => btn.onclick = deleteHandler)
	
	const rreplyBtnList = document.querySelectorAll('button.rreply')
	rreplyBtnList.forEach(btn => btn.onclick = rreplyHandler)
}

function rreplyHandler(event) {
	event.preventDefault()
	const form = document.getElementById('replyWriteForm')
	const reply = event.target.parentNode.parentNode.parentNode
	
	document.querySelectorAll('.reply').forEach(reply => reply.classList.remove('selected'))
	reply.classList.add('selected')
	reply.appendChild(form)
	form.querySelector('textarea').focus()
}

function convertHTMLfromJSON(dto) {
	
	const margin = dto.reply_depth * 30
	
	let html = `<div class="reply" idx="${dto.reply_idx}" style="margin-left: ${margin}px">`
	html += `		<div class="replyTop">`
	html += `			<div class="reply_left">`
	html += `				<div class="reply_writer">${dto.admin_id}</div>`
	html += `			</div>`
	html += `			<div class="reply_right">`
	html += `				<button class="reply_delete" ${login_user_id != dto.admin_id ? 'hidden' : ''}>삭제</button>`
	html += `			</div>`
	html += `		</div>`
	html += `		<pre class="reply_content">${dto.reply_content}</pre>`
	html += `</div>`
	return html
}

function replyWriteHandler(event) {
	event.preventDefault()
	const content = document.querySelector('#replyWriteForm textarea')
	const ob = {
		qboard_idx: qboard_idx,
		user_idx: login_user_idx,
		admin_id: login_user_id,
		reply_content: content.value,
	
	}
	console.log(ob);
	const url = cpath + '/board/reply/' + qboard_idx
	const opt = {
		method: 'POST',
		body: JSON.stringify(ob),
		headers: {
			'Content-Type': 'application/json; charset=utf-8'
		}
	}
	console.log(url);
	console.log(opt);
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(text == 1) {
			alert('작성 성공 !!')
			location.reload()
			content.value = ''
		}
	})
}



