from apistar import test
from app import app


client = test.TestClient(app)

def test_http_request():
    response = client.get('/')
    assert response.status_code == 200
    assert response.json() == {'message': 'Welcome to API Star!'}


test_http_request()
