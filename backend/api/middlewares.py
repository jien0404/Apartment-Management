from flask import jsonify, request, current_app, g
import jwt
from functools import wraps
from helpers import get_payload, validate_token

def login_require(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if not validate_token():
            return jsonify({'message': 'you have not loged in'}), 403

        return f(*args, *kwargs)
    return wrap

def admin_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if not get_payload():
            return jsonify({'message': 'token error'}), 401
        
        payload = get_payload()
        user_role = payload.get('role')
        if user_role not in ('admin', 'sadmin'):
            return jsonify({'message': 'you are not admin'}), 403
        
        return f(*args, **kwargs)
        
    return wrap

def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        if auth_header and auth_header.startswith('Bearer '):
            token = auth_header.split(' ')[1]
        else:
            return jsonify({'message': 'Token is missing'}), 401

        try:
            data = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'message': 'Invalid token'}), 401

        return f(data, *args, **kwargs)

    return decorated