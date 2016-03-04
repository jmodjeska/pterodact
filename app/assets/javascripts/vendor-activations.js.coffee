jQuery ->
    $('.ptrAppTable').dataTable
        aLengthMenu: [[15, 50, 75, -1], [15, 50, 75, "All"]],
        iDisplayLength: 15

    $('[data-toggle="tooltip"]').tooltip()
