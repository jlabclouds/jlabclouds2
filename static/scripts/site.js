        // Search bar logic
        let query = '';
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                query = this.value;
            });
        }
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                console.log('Search query:', query);
                // Add your search logic here
            }
        }
            // Set year in footer
        document.getElementById('year').textContent = new Date().getFullYear();

  // Bootstrap
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
      
