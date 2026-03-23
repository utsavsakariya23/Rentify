<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="components/adminHeader.jsp" %>

                <div class="container-fluid">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="fw-bold">Contact Messages</h2>
                        <div class="input-group" style="width: 280px;">
                            <input type="text" class="form-control" id="messageSearch" placeholder="Search messages..."
                                onkeyup="searchTable('messageSearch', 'messageTableBody')">
                            <button class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card border-0 shadow-sm">
                                <div
                                    class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0 fw-bold"><i class="fas fa-envelope text-primary me-2"></i>Inbox</h5>
                                    <span class="badge bg-danger rounded-pill">3 New</span>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0">
                                            <thead class="bg-light">
                                                <tr>
                                                    <th class="ps-4">Status</th>
                                                    <th>Sender</th>
                                                    <th>Subject</th>
                                                    <th>Date</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody id="messageTableBody">
                                                <!-- Row 1 -->
                                                <tr class="fw-bold bg-white">
                                                    <td class="ps-4"><span class="badge bg-danger">New</span></td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="bg-light rounded-circle p-2 me-2 text-primary">
                                                                <i class="fas fa-user"></i></div>
                                                            <div>
                                                                <div>John Doe</div>
                                                                <div class="small text-muted">john@example.com</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>Inquiry about SUV availability</td>
                                                    <td class="text-muted small">Today, 10:30 AM</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary"
                                                            data-bs-toggle="modal" data-bs-target="#readMessageModal1">
                                                            <i class="fas fa-eye me-1"></i> Read / Reply
                                                        </button>
                                                    </td>
                                                </tr>
                                                <!-- Row 2 -->
                                                <tr>
                                                    <td class="ps-4"><span class="badge bg-success">Replied</span></td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div
                                                                class="bg-light rounded-circle p-2 me-2 text-secondary">
                                                                <i class="fas fa-user"></i></div>
                                                            <div>
                                                                <div>Jane Smith</div>
                                                                <div class="small text-muted">jane@example.com</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>Refund Status</td>
                                                    <td class="text-muted small">Yesterday</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-secondary"
                                                            data-bs-toggle="modal" data-bs-target="#readMessageModal2">
                                                            <i class="fas fa-eye me-1"></i> View
                                                        </button>
                                                    </td>
                                                </tr>
                                                <!-- Row 3 -->
                                                <tr class="fw-bold bg-white">
                                                    <td class="ps-4"><span class="badge bg-danger">New</span></td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="bg-light rounded-circle p-2 me-2 text-primary">
                                                                <i class="fas fa-user"></i></div>
                                                            <div>
                                                                <div>Ravi Patel</div>
                                                                <div class="small text-muted">ravi@example.com</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>Booking cancellation request</td>
                                                    <td class="text-muted small">Today, 2:15 PM</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-eye me-1"></i> Read / Reply
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="card-footer bg-white py-3">
                                    <nav>
                                        <ul class="pagination justify-content-end mb-0">
                                            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">Next</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Message Modal 1 -->
                <div class="modal fade" id="readMessageModal1" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Message Details</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 pb-3 border-bottom">
                                    <div class="d-flex justify-content-between mb-2">
                                        <strong>From: John Doe &lt;john@example.com&gt;</strong>
                                        <span class="text-muted small">Oct 24, 2023 10:30 AM</span>
                                    </div>
                                    <h5>Subject: Inquiry about SUV availability</h5>
                                    <p class="mt-3 text-secondary">
                                        Hi, I would like to know if the Toyota Fortuner is available for rent next
                                        weekend (Oct 28-30). Also, do you offer insurance included in the price? Thanks.
                                    </p>
                                </div>
                                <h6 class="fw-bold text-primary"><i class="fas fa-reply me-2"></i>Reply</h6>
                                <form>
                                    <div class="mb-3">
                                        <textarea class="form-control" rows="5"
                                            placeholder="Type your reply here..."></textarea>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-between">
                                <button type="button" class="btn btn-danger"><i class="fas fa-trash me-1"></i>
                                    Delete</button>
                                <div>
                                    <button type="button" class="btn btn-secondary me-2"
                                        data-bs-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary"><i
                                            class="fas fa-paper-plane me-1"></i> Send Reply</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Search Script -->
                <script>
                function searchTable(inputId, tbodyId) {
                    var filter = document.getElementById(inputId).value.toUpperCase();
                    var rows = document.getElementById(tbodyId).getElementsByTagName('tr');
                    for (var i = 0; i < rows.length; i++) {
                        var text = rows[i].textContent || rows[i].innerText;
                        rows[i].style.display = text.toUpperCase().indexOf(filter) > -1 ? '' : 'none';
                    }
                }
                </script>

                <%@ include file="components/adminFooter.jsp" %>