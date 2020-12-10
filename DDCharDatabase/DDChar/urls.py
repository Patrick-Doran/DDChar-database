from django.urls import path
from . import views

urlpatterns = [
    #url for home
    path('', views.index, name='index'),
    #url for spell
    path('spells/', views.spells, name='spells'),
    path('createChar/', views.createChar, name='createChar'),
    path('edit/', views.edit, name='edit'),
]