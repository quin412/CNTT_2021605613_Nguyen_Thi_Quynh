<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content="Thống kê tổng quát"/>
    <meta name="author" content=""/>
    <title>ADMIN</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="/js/bootstrap.bundle.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/4.1.0/apexcharts.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
    <style>
        button:hover {
            background-color: #009bbf;
        }

    </style>
</head>

<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 30px;">
                    <!-- Bên trái -->
                    <h1 style="margin: 0; font-size: 28px;">THỐNG KÊ</h1>

                    <!-- Bên phải -->
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="font-size: 18px; font-weight: 500;">TẢI BÁO CÁO</span>
                        <button
                                onclick="downloadPdf()"
                                style="padding: 8px 16px; background-color: #00BAEC; color: white; border: none; border-radius: 6px; font-size: 15px; cursor: pointer; transition: 0.3s;">
                            📄
                        </button>
                    </div>
                </div>
                <ol class="breadcrumb mb-4">

                </ol>
                <div class="row">
                    <div class="col-xl-3 col-md-6">
                        <div class="card mb-4">
                            <div class="card-body font-weight-bold2 d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="text-uppercase">Doanh số toàn thời gian</div>
                                    <div class="font-weight-bold"><span><fmt:formatNumber type="number"
                                                                                          value="${totalRevenue}"/></span>
                                    </div>
                                </div>
                                <span class="material-symbols-outlined text-success icon-large">payments</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card mb-4">
                            <div class="card-body font-weight-bold2 d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="text-uppercase">Tổng số khách hàng</div>
                                    <div class="font-weight-bold">${totalCustomer}</div>
                                </div>
                                <span class="material-symbols-outlined text-primary icon-large">group</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card mb-4">
                            <div class="card-body font-weight-bold2 d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="text-uppercase">Tổng số hóa đơn</div>
                                    <div class="font-weight-bold">${totalBill}</div>
                                </div>
                                <span class="material-symbols-outlined text-warning icon-large">receipt_long</span>
                            </div>

                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="card mb-4">
                            <div class="card-body font-weight-bold2 d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="text-uppercase">Tổng số sản phẩm</div>
                                    <div class="font-weight-bold">${totalProduct}</div>
                                </div>
                                <span class="material-symbols-outlined text-danger icon-large">inventory_2</span>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div>
                                    <h5><i class="fas fa-chart-column me-1"></i>
                                        Thống kê doanh thu</h5>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-success" onclick="fetchRevenue('${date}');"
                                            title="Thống kê theo ngày">Ngày
                                    </button>
                                    <button class="btn btn-warning" onclick="fetchRevenue(null, '2025');"
                                            title="Thống kê theo tháng">Tháng
                                    </button>
                                </div>
                            </div>
                            <div class="card-body" style="padding-top: 20px;">
                                <div id="chart-area"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5><i class="fas fa-chart-bar me-1"></i>
                                    Thị phần các hãng</h5>
                            </div>
                            <div class="card-body">
                                <div id="pie-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-header">
                        <h5><i class="fas fa-table me-1"></i>
                            SẢN PHẨM BÁN CHẠY</h5>
                    </div>
                    <div class="card-body">
                        <table id="datatablesSimple" class="table-bordered table-hover table-striped">
                            <thead>
                            <tr>
                                <th>Mã sản phẩm</th>
                                <th>Tên</th>
                                <th>Nhà sản xuất</th>
                                <th>Giá</th>
                                <th>Doanh số</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
                <div class="card mb-4">
                    <div class="card-header">
                        <h5><i class="fas fa-table me-1"></i>
                            SẢN PHẨM BÁN CHẬM
                        </h5>
                    </div>
                    <div class="card-body">
                        <table id="lowSalesTable" class="table-bordered table-hover table-striped">
                            <thead>
                            <tr>
                                <th>Mã sản phẩm</th>
                                <th>Tên</th>
                                <th>Nhà sản xuất</th>
                                <th>Giá</th>
                                <th>Doanh số</th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>

<script>
    const chartData = {
        xAxis: [],
        yAxis: []
    };

    // Function to load data with a dynamic startDate
    async function fetchRevenue(startDate, year) {
        let url = '/revenue';
        if (startDate) {
            url += `?startDate=` + startDate;
        } else if (year) {
            url += `?year=` + year;
        } else {
            throw new Error('Either startDate or year must be provided');
        }

        try {
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const datarevenue = await response.json();

            chartData.xAxis = datarevenue.map(revenue => revenue.label);
            chartData.yAxis = datarevenue.map(revenue => revenue.totalRevenue);

            var options1 = {
                chart: {
                    id: "revenueChart",
                    type: "area",
                    height: 350,
                    toolbar: {
                        show: true
                    }
                },
                title: {
                    text: "Biểu đồ Doanh Thu",
                    align: 'left',
                    style: {
                        fontSize: '16px',
                        fontWeight: 'bold',
                        color: '#263238'
                    }
                },
                colors: ["#00BAEC"],
                stroke: {
                    curve: 'smooth',
                    width: 3
                },
                grid: {
                    borderColor: "#e0e0e0",
                    strokeDashArray: 4,
                },
                dataLabels: {
                    enabled: false
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shadeIntensity: 1,
                        opacityFrom: 0.5,
                        opacityTo: 0.1,
                        stops: [0, 90, 100]
                    }
                },
                markers: {
                    size: 4,
                    colors: ["#ffffff"],
                    strokeColors: "#00BAEC",
                    strokeWidth: 2
                },
                series: [
                    {
                        name: "Doanh thu (VNĐ)",
                        data: chartData.yAxis
                    }
                ],
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('vi-VN', {
                                style: 'currency',
                                currency: 'VND'
                            }).format(val);
                        }
                    },
                    theme: "light"
                },
                xaxis: {
                    type: "datetime",
                    categories: chartData.xAxis,
                    labels: {
                        datetimeFormatter: {
                            year: 'yyyy',
                            month: 'MM/yyyy',
                            day: 'dd/MM'
                        }
                    },
                    title: {
                        text: 'Thời gian'
                    }
                },
                yaxis: {
                    min: 0,
                    labels: {
                        formatter: function (val) {
                            return new Intl.NumberFormat('vi-VN').format(val);
                        }
                    },
                    title: {
                        text: 'Doanh thu (VNĐ)'
                    }
                },
                legend: {
                    position: 'top',
                    horizontalAlign: 'right'
                }
            };

            if (window.chart1) {
                window.chart1.destroy(); // Xóa biểu đồ cũ nếu có
            }
            window.chart1 = new ApexCharts(document.querySelector("#chart-area"), options1);
            window.chart1.render(); // Vẽ biểu đồ mới
        } catch (error) {
            console.error("Error loading revenue data:", error);
        } finally {
            // Reset the URL
            url = '/revenue';
        }
    }

    // Load default data on page load
    document.addEventListener("DOMContentLoaded", () => {
        fetchRevenue('${date}'); // Call the function with the default start date
    });
</script>

<script>
    const pieChartDataC = {
        series: [],
        labels: []
    };

    <c:forEach var="datapie" items="${pieChartData}">
    pieChartDataC.series.push(${datapie.marketShare});
    pieChartDataC.labels.push("${datapie.name}");
    </c:forEach>

    const options2 = {
        chart: {
            type: 'donut',
            height: 360,
            toolbar: {
                show: true
            }
        },
        title: {
            text: 'Thị phần các hãng sản xuất',
            align: 'center',
            style: {
                fontSize: '18px',
                fontWeight: 'bold',
                color: '#263238'
            }
        },
        labels: pieChartDataC.labels,
        series: pieChartDataC.series,
        legend: {
            position: 'right',
            horizontalAlign: 'center',
            fontSize: '14px',
            markers: {
                width: 12,
                height: 12
            },
            itemMargin: {
                vertical: 5
            }
        },
        dataLabels: {
            enabled: true,
            formatter: function (val, opts) {
                return val.toFixed(1) + '%';
            },
            style: {
                fontSize: '14px',
                fontWeight: 'bold',
                colors: ['#fff']
            },
            dropShadow: {
                enabled: true,
                top: 1,
                left: 1,
                blur: 1,
                color: '#000',
                opacity: 0.5
            }
        },
        tooltip: {
            y: {
                formatter: function (val) {
                    return val.toFixed(2) + '%';
                },
                title: {
                    formatter: function (seriesName) {
                        return seriesName;
                    }
                }
            }
        },
        colors: ['#00BAEC', '#FFA500', '#FF4560', '#775DD0', '#4CAF50', '#E91E63', '#9C27B0'],
        responsive: [{
            breakpoint: 480,
            options: {
                chart: {
                    height: 300
                },
                legend: {
                    position: 'bottom'
                }
            }
        }]
    };

    const chart2 = new ApexCharts(document.querySelector("#pie-chart"), options2);
    chart2.render();
</script>


<script>
    let dataTable; // Global variable to hold the DataTable instance

    async function loadData(orderBy) {
        try {
            const response = await fetch(`/top-products?orderBy=` + orderBy);
            const data = await response.json();

            //console.log(data);
            const products = data;

            const tableBody = document.querySelector("#datatablesSimple tbody");
            tableBody.innerHTML = ""; // Clear existing rows

            // Populate the table
            products
                .filter(product => product.totalSales >= 1) // lọc doanh số ≥ 1
                .forEach(product => {
                    const row = tableBody.insertRow(); // Create a new row

                    // Add cells to the row
                    const cellId = row.insertCell(0);
                    const cellName = row.insertCell(1);
                    const cellCategory = row.insertCell(2);
                    const cellPrice = row.insertCell(3);
                    const cellSales = row.insertCell(4);

                    // Fill the cells with data
                    cellId.textContent = product.productId;
                    cellName.textContent = product.name;
                    cellCategory.textContent = product.categoryName;
                    cellPrice.textContent = new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(product.price);
                    cellSales.textContent = product.totalSales;
                });

            // Initialize or refresh Simple-DataTables
            if (dataTable) {
                // If already initialized, refresh it
                dataTable.refresh();
            } else {
                // Initialize the DataTable
                dataTable = new simpleDatatables.DataTable("#datatablesSimple", {
                    labels: {
                        placeholder: "Tìm kiếm...", // Custom placeholder text
                        perPage: "Số lượng hiển thị trên một trang", // Customize "entries per page"
                        info: "Hiển thị {start} đến {end} trong tổng số {rows} mục"
                    }
                });
            }
        } catch (error) {
            console.error("Error loading data:", error);
        }
    }

    // Load default data on page load
    document.addEventListener("DOMContentLoaded", () => {
        loadData("DESC");
        loadLowSellingProducts();
    });
</script>

<script>
    let lowSalesTableInstance;

    async function loadLowSellingProducts() {
        try {
            const response = await fetch("/low-selling-products"); // đảm bảo API này tồn tại
            const data = await response.json();
            const tableBody = document.querySelector("#lowSalesTable tbody");
            tableBody.innerHTML = ""; // Clear existing rows

            data.forEach(product => {
                const row = tableBody.insertRow();

                const cellId = row.insertCell(0);
                const cellName = row.insertCell(1);
                const cellCategory = row.insertCell(2);
                const cellPrice = row.insertCell(3);
                const cellSales = row.insertCell(4);

                cellId.textContent = product.productId;
                cellName.textContent = product.name;
                cellCategory.textContent = product.categoryName;
                cellPrice.textContent = new Intl.NumberFormat('vi-VN', {
                    style: 'currency', currency: 'VND'
                }).format(product.price);
                cellSales.textContent = product.totalSales;
            });

            // Initialize or refresh the DataTable
            if (lowSalesTableInstance) {
                lowSalesTableInstance.refresh();
            } else {
                lowSalesTableInstance = new simpleDatatables.DataTable("#lowSalesTable", {
                    labels: {
                        placeholder: "Tìm kiếm...",
                        perPage: "Số lượng hiển thị",
                        info: "Hiển thị {start} đến {end} trong tổng số {rows} mục"
                    }
                });
            }

        } catch (error) {
            console.error("Error loading low-selling products:", error);
        }
    }


</script>

<script>
    async function downloadPdf() {
        try {
            const response = await fetch('/admin/export', {
                method: 'GET',
                headers: {
                    'Accept': 'application/pdf'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to download PDF');
            }

            // Convert the response to a Blob
            const blob = await response.blob();

            // Create a temporary URL for the Blob
            const url = window.URL.createObjectURL(blob);

            // Create a temporary link element
            const a = document.createElement('a');
            a.href = url;
            a.download = 'Baocaotongquat.pdf'; // Set the filename
            document.body.appendChild(a);
            a.click(); // Trigger the download
            a.remove(); // Remove the link from the DOM

            // Revoke the temporary URL
            window.URL.revokeObjectURL(url);
        } catch (error) {
            console.error('Error downloading the PDF:', error);
            alert('Failed to download the PDF.');
        }
    }
</script>
</body>
</html>