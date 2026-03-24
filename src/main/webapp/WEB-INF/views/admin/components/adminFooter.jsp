<%@ page contentType="text/html;charset=UTF-8" language="java" %>

            <footer class="admin-footer">
                <span class="text-muted">&copy; 2026 RENTIFY Admin Panel. All rights reserved.</span>
            </footer>

            </div><!-- /.admin-content -->
        </div><!-- /.admin-wrapper -->

<script src="${pageContext.request.contextPath}/assets/bootstrap/js/jquery-3.6.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.js"></script>
<script src="${pageContext.request.contextPath}/assets/controller/url.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>

<script>
(function() {
    const sidebar   = document.getElementById('adminSidebar');
    const overlay   = document.getElementById('sidebarOverlay');
    const toggle    = document.getElementById('sidebarToggle');
    const body      = document.body;
    const MOBILE_BP = 992;

    function isMobile() {
        return window.innerWidth < MOBILE_BP;
    }

    // Toggle behaviour
    if (toggle) {
        toggle.addEventListener('click', function() {
            if (isMobile()) {
                sidebar.classList.toggle('mobile-open');
                overlay.classList.toggle('show');
            } else {
                body.classList.toggle('sidebar-collapsed');
            }
        });
    }

    // Close sidebar on overlay click (mobile)
    if (overlay) {
        overlay.addEventListener('click', function() {
            sidebar.classList.remove('mobile-open');
            overlay.classList.remove('show');
        });
    }

    // Auto-close mobile sidebar on resize to desktop
    window.addEventListener('resize', function() {
        if (!isMobile()) {
            sidebar.classList.remove('mobile-open');
            overlay.classList.remove('show');
        }
    });

    // Highlight active navigation link
    (function highlightActiveNav() {
        var currentPath = window.location.pathname;
        var links = document.querySelectorAll('.sidebar-nav .nav-link');
        links.forEach(function(link) {
            var href = link.getAttribute('href');
            if (href && currentPath.indexOf(href) !== -1) {
                link.classList.add('active');
            }
        });

        // If no exact match, try matching by last path segment
        if (!document.querySelector('.sidebar-nav .nav-link.active')) {
            var segments = currentPath.split('/');
            var lastSeg = segments[segments.length - 1] || segments[segments.length - 2];
            links.forEach(function(link) {
                var href = link.getAttribute('href');
                if (href && href.indexOf('/' + lastSeg) !== -1) {
                    link.classList.add('active');
                }
            });
        }
    })();
})();
</script>

</body>
</html>
