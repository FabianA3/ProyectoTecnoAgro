const btnEliminar = document.querySelectorAll('.btn-eliminar')
if(btnEliminar){
    const btnArray = Array.from(btnEliminar)
    btnArray.forEach((btn) =>{
        btn.addEventListener('click', (e) =>{
            if(!confirm('Esta seguro(a) de eliminar esta cuenta')){
                e.preventDefault();
            }
        })
    })
}