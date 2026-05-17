<%-- WEB-INF/views/common/modal.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="customModalOverlay" class="modal-overlay">
    <div class="custom-modal">
        <div class="modal-header">
            <h3 id="customModalTitle" class="modal-title">Confirm Action</h3>
            <button id="customModalClose" class="modal-close" onclick="closeCustomModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p id="customModalMessage">Are you sure you want to proceed?</p>
        </div>
        <div class="modal-footer">
            <button id="customModalCancel" class="btn btn-secondary" style="padding: 10px 20px; border-radius: 8px; font-weight: 600;" onclick="closeCustomModal()">Cancel</button>
            <button id="customModalConfirm" class="btn" style="padding: 10px 20px; border-radius: 8px; font-weight: 600;">Confirm</button>
        </div>
    </div>
</div>

<script>
    let customModalCallback = null;

    function showModal(title, message, onConfirm, confirmText = 'Confirm', isDanger = false) {
        document.getElementById('customModalTitle').textContent = title;
        document.getElementById('customModalMessage').textContent = message;
        
        const confirmBtn = document.getElementById('customModalConfirm');
        confirmBtn.textContent = confirmText;
        
        if (isDanger) {
            confirmBtn.className = 'btn btn-danger';
            confirmBtn.style.backgroundColor = 'var(--danger)';
            confirmBtn.style.borderColor = 'var(--danger)';
            confirmBtn.style.color = 'white';
        } else {
            confirmBtn.className = 'btn btn-primary';
            confirmBtn.style.backgroundColor = 'var(--primary)';
            confirmBtn.style.borderColor = 'var(--primary)';
            confirmBtn.style.color = 'white';
        }
        
        customModalCallback = onConfirm;
        
        const overlay = document.getElementById('customModalOverlay');
        overlay.style.display = 'flex';
        // Allow display flex to paint before adding active class for transition
        setTimeout(() => {
            overlay.classList.add('active');
        }, 10);
    }

    function closeCustomModal() {
        const overlay = document.getElementById('customModalOverlay');
        overlay.classList.remove('active');
        setTimeout(() => {
            overlay.style.display = 'none';
        }, 300); // Wait for transition out to finish
        customModalCallback = null;
    }

    document.getElementById('customModalConfirm').addEventListener('click', function() {
        if (customModalCallback && typeof customModalCallback === 'function') {
            customModalCallback();
        }
        closeCustomModal();
    });

    // Close on clicking overlay background
    document.getElementById('customModalOverlay').addEventListener('click', function(e) {
        if (e.target === this) {
            closeCustomModal();
        }
    });
</script>
