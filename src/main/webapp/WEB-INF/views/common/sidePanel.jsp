<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="side-panel-overlay" id="sidePanelOverlay"></div>
<div class="side-panel" id="sidePanel">
    <div class="side-panel-header">
        <h2 id="sidePanelTitle">Details</h2>
        <button class="close-panel" id="closePanel">&times;</button>
    </div>
    <div class="side-panel-body">
        <div id="sidePanelAlert" class="alert alert-danger" style="display: none; margin-bottom: 16px;"></div>
        <form id="sidePanelForm" method="post" action="">
            <div id="dynamicFields">
                <!-- Fields will be populated here -->
            </div>
            <input type="hidden" name="action" id="panelAction" value="update">
            <input type="hidden" name="id" id="panelId" value="">
        </form>
    </div>
    <div class="side-panel-footer">
        <button type="button" class="btn btn-secondary" id="closeBtnFooter">Close</button>
        <div id="adminActions" style="display: none; gap: 12px; flex-wrap: wrap;">
            <button type="button" class="btn btn-danger" id="deleteBtn">Delete</button>
            <button type="button" class="btn btn-orange" id="lockBtn" style="display: none;">Lock Account</button>
            <button type="button" class="btn btn-green" id="unlockBtn" style="display: none;">Unlock Account</button>
            <button type="button" class="btn btn-primary" id="saveBtn">Save Changes</button>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const sidePanel = document.getElementById('sidePanel');
    const overlay = document.getElementById('sidePanelOverlay');
    const closePanelBtn = document.getElementById('closePanel');
    const closeBtnFooter = document.getElementById('closeBtnFooter');
    const adminActions = document.getElementById('adminActions');
    
    const sidePanelTitle = document.getElementById('sidePanelTitle');
    const dynamicFields = document.getElementById('dynamicFields');
    const panelForm = document.getElementById('sidePanelForm');
    const panelIdInput = document.getElementById('panelId');
    const panelActionInput = document.getElementById('panelAction');
    const deleteBtn = document.getElementById('deleteBtn');
    const lockBtn = document.getElementById('lockBtn');
    const unlockBtn = document.getElementById('unlockBtn');
    const saveBtn = document.getElementById('saveBtn');

    // Safe role check from session
    const userRole = '${sessionScope.role}';
    const isAdmin = userRole === 'ADMIN';
    const isHospital = userRole === 'HOSPITAL';
    const currentUserName = '<c:out value="${sessionScope.fullName}" />';
    const contextPath = '${pageContext.request.contextPath}';

    function closePanel() {
        if (sidePanel) sidePanel.classList.remove('open');
        if (overlay) overlay.style.display = 'none';
    }

    if (closePanelBtn) closePanelBtn.onclick = closePanel;
    if (closeBtnFooter) closeBtnFooter.onclick = closePanel;
    if (overlay) overlay.onclick = closePanel;

    // Attach click events to all table rows
    const tables = document.querySelectorAll('.data-table');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('thead th')).map(th => th.innerText.trim());
        const rows = table.querySelectorAll('tbody tr');
        
        rows.forEach(row => {
            if (row.querySelector('.text-center') && row.cells.length === 1) return;

            row.addEventListener('click', function(e) {
                if (e.target.tagName === 'BUTTON' || e.target.tagName === 'A' || e.target.closest('button') || e.target.closest('form')) {
                    return;
                }
                openPanel(row, headers, table.id);
            });
        });
    });

    function openPanel(row, headers, tableId) {
        if (!dynamicFields) return;
        dynamicFields.innerHTML = '';
        sidePanelTitle.innerText = 'Record Details';
        
        let actionUrl = window.location.pathname;
        panelForm.action = actionUrl;

        let isOwner = true;
        if (isHospital) {
            if (tableId === 'annTable' || tableId === 'noticeTable') {
                isOwner = false;
                const authorIndex = headers.findIndex(h => h.toLowerCase() === 'author');
                if (authorIndex !== -1) {
                    const authorName = row.cells[authorIndex].innerText.trim().toLowerCase();
                    const currentTitle = currentUserName.trim().toLowerCase();
                    isOwner = (authorName === currentTitle);
                }
            } else if (tableId === 'myAnnTable' || tableId === 'organTable') {
                isOwner = true;
            } else if (tableId === 'allOrgansTable') {
                isOwner = false;
            }
        }

        if (adminActions) {
            if (isAdmin || (isHospital && isOwner)) {
                adminActions.style.setProperty('display', 'flex', 'important');
                if (closeBtnFooter) closeBtnFooter.innerText = 'Cancel';
                
                if (isAdmin && (tableId === 'memberTable' || tableId === 'hospitalTable')) {
                    lockBtn.style.display = 'block';
                    unlockBtn.style.display = 'block';
                } else {
                    lockBtn.style.display = 'none';
                    unlockBtn.style.display = 'none';
                }

                if (tableId === 'queryTable') {
                    if (saveBtn) saveBtn.style.display = 'none';
                } else {
                    if (saveBtn) saveBtn.style.display = 'block';
                }
            } else {
                adminActions.style.setProperty('display', 'none', 'important');
                if (closeBtnFooter) closeBtnFooter.innerText = 'Close';
            }
        }

        Array.from(row.cells).forEach((cell, index) => {
            const header = headers[index];
            if (!header || header === 'ACTIONS' || header === 'Action') return;

            const value = cell.innerText.trim();
            const group = document.createElement('div');
            group.className = 'form-group';

            const label = document.createElement('label');
            label.innerText = header;
            group.appendChild(label);

            let input;
            if (header.toLowerCase().includes('description') || header.toLowerCase().includes('content')) {
                input = document.createElement('textarea');
                input.className = 'form-control';
                input.rows = 4;
            } else {
                input = document.createElement('input');
                input.type = 'text';
                input.className = 'form-control';
            }

            input.value = value;
            input.name = header.toLowerCase().replace(/\s+/g, '_');
            
            if (!isAdmin && !(isHospital && isOwner)) {
                input.readOnly = true;
            }
            
            if (header.toLowerCase() === 'id') {
                panelIdInput.value = value;
                input.readOnly = true;
                input.name = 'id';
            }

            const uneditableFields = ['username', 'license', 'registered', 'requested', 'date', 'submitted on'];
            if (uneditableFields.includes(header.toLowerCase()) || tableId === 'queryTable') {
                input.readOnly = true;
                input.classList.add('read-only-field');
            }
            
            group.appendChild(input);
            dynamicFields.appendChild(group);
        });

        if (isAdmin || (isHospital && isOwner)) {
            if (deleteBtn) {
                deleteBtn.onclick = function() {
                    showModal('Delete Record', 'Are you sure you want to permanently delete this record?', function() {
                        const deleteForm = document.createElement('form');
                        deleteForm.method = 'post';
                        deleteForm.action = actionUrl.includes('admin') ? contextPath + '/admin' : actionUrl;
                        
                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        
                        if (tableId === 'memberTable') actionInput.value = 'deleteMember';
                        else if (tableId === 'hospitalTable') actionInput.value = 'deleteHospital';
                        else if (tableId === 'annTable' || tableId === 'noticeTable' || tableId === 'myAnnTable') actionInput.value = 'deleteAnnouncement';
                        else if (tableId === 'organTable') actionInput.value = 'deleteOrgan';
                        else if (tableId === 'requestTable') actionInput.value = 'deleteRequest';
                        else if (tableId === 'myReqTable') actionInput.value = 'deleteRequest';
                        else if (tableId === 'queryTable') actionInput.value = 'deleteQuery';
                        else actionInput.value = 'delete';

                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'id';
                        idInput.value = panelIdInput.value;

                        deleteForm.appendChild(actionInput);
                        deleteForm.appendChild(idInput);
                        document.body.appendChild(deleteForm);
                        deleteForm.submit();
                    }, 'Delete', true);
                };
            }

            if (saveBtn) {
                saveBtn.onclick = function() {
                    panelActionInput.value = 'update';
                    panelForm.submit();
                };
            }

            if (lockBtn) {
                lockBtn.onclick = function() {
                    showModal('Lock Account', 'Are you sure you want to lock this account?', function() {
                        const form = document.createElement('form');
                        form.method = 'post';
                        form.action = contextPath + '/admin';
                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'lockUser';
                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'id';
                        idInput.value = panelIdInput.value;
                        const roleInput = document.createElement('input');
                        roleInput.type = 'hidden';
                        roleInput.name = 'role';
                        roleInput.value = tableId === 'memberTable' ? 'MEMBER' : 'HOSPITAL';
                        form.appendChild(actionInput);
                        form.appendChild(idInput);
                        form.appendChild(roleInput);
                        document.body.appendChild(form);
                        form.submit();
                    }, 'Lock Account', true);
                };
            }

            if (unlockBtn) {
                unlockBtn.onclick = function() {
                    showModal('Unlock Account', 'Are you sure you want to unlock this account?', function() {
                        const form = document.createElement('form');
                        form.method = 'post';
                        form.action = contextPath + '/admin';
                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'unlockUser';
                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'id';
                        idInput.value = panelIdInput.value;
                        const roleInput = document.createElement('input');
                        roleInput.type = 'hidden';
                        roleInput.name = 'role';
                        roleInput.value = tableId === 'memberTable' ? 'MEMBER' : 'HOSPITAL';
                        form.appendChild(actionInput);
                        form.appendChild(idInput);
                        form.appendChild(roleInput);
                        document.body.appendChild(form);
                        form.submit();
                    }, 'Unlock Account', false);
                };
            }
        }

        if (sidePanel) sidePanel.classList.add('open');
        if (overlay) overlay.style.display = 'block';
    }

    // Form Validation Logic
    if (panelForm) {
        panelForm.addEventListener('submit', function(e) {
            const inputs = this.querySelectorAll('input, select');
            let fullNameVal = '', emailVal = '', phoneVal = '';
            
            inputs.forEach(input => {
                const name = input.name.toLowerCase();
                const val = input.value.trim();
                if (name.includes('full_name') || name.includes('hospital_name')) fullNameVal = val;
                if (name.includes('email')) emailVal = val;
                if (name.includes('phone')) phoneVal = val;
            });

            function showSidePanelError(msg) {
                const spAlert = document.getElementById('sidePanelAlert');
                if (spAlert) {
                    spAlert.style.display = 'block';
                    spAlert.innerText = msg;
                }
            }

            if (fullNameVal && /\d/.test(fullNameVal)) {
                showSidePanelError('Full Name must not contain digits.');
                e.preventDefault();
                return;
            }
            if (emailVal) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailVal)) {
                    showSidePanelError('Enter valid email.');
                    e.preventDefault();
                    return;
                }
            }
            if (phoneVal) {
                const phoneRegex = /^\d{10}$/;
                if (!phoneRegex.test(phoneVal)) {
                    showSidePanelError('Phone number must be exactly 10 digits.');
                    e.preventDefault();
                    return;
                }
            }
        });
    }
});
</script>
