<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="components/adminHeader.jsp" %>

<style>
.finance-card { background: white; border-radius: 16px; padding: 1.5rem; box-shadow: 0 2px 12px rgba(0,0,0,0.07); }
.gst-badge { background: linear-gradient(135deg, #198754, #0f5132); color: white; border-radius: 12px; padding: 0.75rem 1.5rem; }
</style>

<main class="container-fluid my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-0">💰 Finance & Tax Management</h2>
            <p class="text-muted small mb-0">GST-aware income statements, expenses, and net profit</p>
        </div>
        <div class="d-flex gap-2 align-items-center">
            <!-- Year Selector -->
            <form method="get" action="${pageContext.request.contextPath}/admin/finance" class="d-flex gap-2">
                <select name="year" class="form-select" style="width:120px;">
                    <c:forEach begin="2023" end="2027" var="y">
                        <option value="${y}" ${selectedYear == y ? 'selected' : ''}>${y}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-primary">View</button>
            </form>
            <button onclick="window.print()" class="btn btn-outline-secondary"><i class="fas fa-print me-1"></i>Print</button>
        </div>
    </div>

    <!-- Current Month Statement -->
    <div class="row g-3 mb-4">
        <div class="col-md-8">
            <div class="finance-card h-100">
                <h5 class="fw-bold mb-3">📅 ${currentMonth} ${currentYear} — Income Statement</h5>
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="border rounded p-3 text-center">
                            <div class="small text-muted fw-bold">GROSS REVENUE</div>
                            <h4 class="fw-bold text-primary">Rs. <fmt:formatNumber value="${currentMonthStmt.grossRevenue}" pattern="#,##0"/></h4>
                            <small class="text-muted">Total paid bookings</small>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="border rounded p-3 text-center" style="border-color: #dc3545 !important;">
                            <div class="small text-muted fw-bold">GST (${gstRate}%)</div>
                            <h5 class="fw-bold text-danger"><fmt:formatNumber value="${currentMonthStmt.gstCollected}" pattern="#,##0"/></h5>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="border rounded p-3 text-center" style="border-color: #ffc107 !important;">
                            <div class="small text-muted fw-bold">EXPENSES</div>
                            <h5 class="fw-bold text-warning"><fmt:formatNumber value="${currentMonthStmt.totalExpenses}" pattern="#,##0"/></h5>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="border rounded p-3 text-center" style="border-color: #198754 !important;">
                            <div class="small text-muted fw-bold">NET PROFIT</div>
                            <h4 class="fw-bold text-success">Rs. <fmt:formatNumber value="${currentMonthStmt.netProfit}" pattern="#,##0"/></h4>
                            <small class="text-muted">Net Revenue - Expenses</small>
                        </div>
                    </div>
                </div>
                <div class="mt-3 p-3 rounded" style="background: #f8f9fa;">
                    <small class="text-muted"><i class="fas fa-info-circle me-1"></i>GST is calculated inclusive: GST = Revenue × ${gstRate}/(100+${gstRate}). Profit = Net Revenue - Expenses.</small>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="finance-card h-100">
                <h5 class="fw-bold mb-3">📊 ${selectedYear} Quarterly GST</h5>
                <c:forEach var="q" items="${quarterlyGST}">
                    <div class="d-flex justify-content-between align-items-center border-bottom py-2">
                        <div class="fw-bold small">${q.key}</div>
                        <div class="text-danger fw-bold">Rs. <fmt:formatNumber value="${q.value}" pattern="#,##0"/></div>
                    </div>
                </c:forEach>
                <div class="mt-3 p-2 rounded text-center gst-badge">
                    <small class="fw-bold">GST RATE: ${gstRate}%</small><br>
                    <small>Standard Car Rental GST (India)</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Yearly Summary Table -->
    <div class="finance-card mb-4">
        <h5 class="fw-bold mb-3">📅 ${selectedYear} Monthly Breakdown</h5>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Month</th>
                        <th>Total Bookings</th>
                        <th>Gross Revenue</th>
                        <th>GST (${gstRate}%)</th>
                        <th>Net Revenue</th>
                        <th>Expenses</th>
                        <th>Net Profit</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${yearlySummary}">
                        <tr>
                            <td class="fw-bold">${row.monthName}</td>
                            <td><span class="badge bg-secondary">${row.bookingCount}</span></td>
                            <td>Rs. <fmt:formatNumber value="${row.revenue}" pattern="#,##0"/></td>
                            <td class="text-danger">Rs. <fmt:formatNumber value="${row.gst}" pattern="#,##0"/></td>
                            <td class="text-secondary">Rs. <fmt:formatNumber value="${row.netRevenue}" pattern="#,##0"/></td>
                            <td class="text-warning">Rs. <fmt:formatNumber value="${row.expenses}" pattern="#,##0"/></td>
                            <td class="text-success fw-bold">Rs. <fmt:formatNumber value="${row.profit}" pattern="#,##0"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty yearlySummary}">
                        <tr><td colspan="7" class="text-center text-muted py-4">No data for ${selectedYear}</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Expenses -->
    <div class="finance-card mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="fw-bold mb-0">📉 Recent Expenses</h5>
            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#addExpenseModal"><i class="fas fa-plus me-1"></i>Add Expense</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light text-uppercase small">
                    <tr>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Amount</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="exp" items="${recentExpenses}">
                        <tr>
                            <td><fmt:formatDate value="${exp.expenseDate}" pattern="dd MMM yyyy" /></td>
                            <td>${exp.description}</td>
                            <td><span class="badge bg-info text-dark">${exp.category}</span></td>
                            <td class="fw-bold text-danger">Rs. <fmt:formatNumber value="${exp.amount}" pattern="#,##0"/></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/delete_expense" method="post" onsubmit="return confirm('Delete this expense?');">
                                    <input type="hidden" name="expenseId" value="${exp.expenseId}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger"><i class="fas fa-trash"></i></button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty recentExpenses}">
                        <tr><td colspan="5" class="text-center text-muted py-4">No expenses recorded yet.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add Expense Modal -->
    <div class="modal fade" id="addExpenseModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Record Expense</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/add_expense" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <input type="text" name="description" class="form-control" required placeholder="e.g., Office Rent, Server Cost" maxlength="255">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select name="category" class="form-select">
                                <option value="Fleet Maintenance">Fleet Maintenance</option>
                                <option value="Salary">Salary</option>
                                <option value="Office Rent">Office Rent</option>
                                <option value="Marketing">Marketing</option>
                                <option value="Software/IT">Software/IT</option>
                                <option value="General" selected>General/Other</option>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label">Amount (Rs.)</label>
                                <input type="number" name="amount" class="form-control" id="expenseAmount" required min="1" step="0.01">
                                <div class="invalid-feedback">Must be a positive value.</div>
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" name="expenseDate" id="expenseDateInput" class="form-control" required>
                                <div class="invalid-feedback">Please select a valid past or current date.</div>
                            </div>
                        </div>
                        
                        <script>
                            // Set Max Date to Today
                            document.addEventListener("DOMContentLoaded", function() {
                                let today = new Date().toISOString().split("T")[0];
                                document.getElementById("expenseDateInput").setAttribute("max", today);
                                document.getElementById("expenseDateInput").setAttribute("value", today);
                            });
                        </script>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Expense</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<%@ include file="components/adminFooter.jsp" %>
