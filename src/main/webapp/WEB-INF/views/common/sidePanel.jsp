<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="side-panel-overlay" id="sidePanelOverlay"></div>
<div class="side-panel" id="sidePanel">
    <div class="side-panel-header">
        <h2 id="sidePanelTitle">Details</h2>
        <button class="close-panel" id="closePanel">&times;</button>
    </div>
    <div class="side-panel-body">
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
            // Skip "No content" rows
            if (row.querySelector('.text-center') && row.cells.length === 1) return;

            row.addEventListener('click', function(e) {
                // Don't open if clicking on a button or link inside the row
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

        // Ownership check for Hospitals
        let isOwner = true;
        if (isHospital) {
            // Default to false for announcements unless verified or in personal table
            if (tableId === 'annTable' || tableId === 'noticeTable') {
                isOwner = false;
                const authorIndex = headers.findIndex(h => h.toLowerCase() === 'author');
                if (authorIndex !== -1) {
                    const authorName = row.cells[authorIndex].innerText.trim().toLowerCase();
                    const currentTitle = currentUserName.trim().toLowerCase();
                    isOwner = (authorName === currentTitle);
                }
            } else if (tableId === 'myAnnTable') {
                isOwner = true; // Assume owner if in "My" table
            }
        }

        if (adminActions) {
            if (isAdmin || (isHospital && isOwner)) {
                adminActions.style.setProperty('display', 'flex', 'important');
                if (closeBtnFooter) closeBtnFooter.innerText = 'Cancel';
                
                // Show/Hide Lock buttons for users
                if (isAdmin && (tableId === 'memberTable' || tableId === 'hospitalTable')) {
                    lockBtn.style.display = 'block';
                    unlockBtn.style.display = 'block';
                } else {
                    lockBtn.style.display = 'none';
                    unlockBtn.style.display = 'none';
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
            
            // Handle specific ID fields for update/delete
            if (header.toLowerCase() === 'id') {
                panelIdInput.value = value;
                input.readOnly = true; // Never edit primary ID directly
                input.name = 'id';
            }

            // Fields that cannot be edited or updated
            const uneditableFields = ['username', 'license', 'registered', 'requested', 'date'];
            if (uneditableFields.includes(header.toLowerCase())) {
                input.readOnly = true;
                input.classList.add('read-only-field'); // Optional: add a class for styling
            }

            // Custom mapping for specific tables if needed
            // Default: header "Full Name" -> input name "full_name"
            
            group.appendChild(input);
            dynamicFields.appendChild(group);
        });

        if (isAdmin || (isHospital && isOwner)) {
            if (deleteBtn) {
                deleteBtn.onclick = function() {
                    if (confirm('Are you sure you want to delete this record?')) {
                        const deleteForm = document.createElement('form');
                        deleteForm.method = 'post';
                        // Ensure it goes to the right controller
                        deleteForm.action = actionUrl.includes('admin') ? contextPath + '/admin' : actionUrl;
                        
                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        
                        if (tableId === 'memberTable') actionInput.value = 'deleteMember';
                        else if (tableId === 'hospitalTable') actionInput.value = 'deleteHospital';
                        else if (tableId === 'annTable' || tableId === 'noticeTable' || tableId === 'myAnnTable') actionInput.value = 'deleteAnnouncement';
                        else if (tableId === 'organTable') actionInput.value = 'deleteOrgan';
                        else if (tableId === 'requestTable') actionInput.value = 'deleteRequest';
                        else actionInput.value = 'delete';

                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'id';
                        idInput.value = panelIdInput.value;

                        deleteForm.appendChild(actionInput);
                        deleteForm.appendChild(idInput);
                        document.body.appendChild(deleteForm);
                        deleteForm.submit();
                    }
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
                    if (confirm('Lock this account? User will not be able to login.')) {
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
                    }
                };
            }

            if (unlockBtn) {
                unlockBtn.onclick = function() {
                    if (confirm('Unlock this account?')) {
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
                    }
                };
            }
        }

        if (sidePanel) sidePanel.classList.add('open');
        if (overlay) overlay.style.display = 'block';
    }
});
</script>
