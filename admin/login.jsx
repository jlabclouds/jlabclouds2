        import React, { useState } from 'react';

        function LoginForm() {
          const [username, setUsername] = useState('');
          const [password, setPassword] = useState('');

          const handleSubmit = async (e) => {
            e.preventDefault();
            // Send credentials securely to backend
            await fetch('/admin/login', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({ username, password }),
            });
          };

          return (
            <form onSubmit={handleSubmit}>
              <input
                type="text"
                value={username}
                onChange={e => setUsername(e.target.value)}
                placeholder="Username"
                required
              />
              <input
                type="password"
                value={password}
                onChange={e => setPassword(e.target.value)}
                placeholder="Password"
                required
              />
              <button type="submit">Login</button>
            </form>
          );
        }

        export default LoginForm;
