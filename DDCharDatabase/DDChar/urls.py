from django.urls import path

from . import views

urlpatterns = [
    #index
    path('', views.index, name='index'),
    #/DDChar/character/userName
    path('character/<userName>/', views.getUser, name='character'),
    path('userAll/', views.listUsers),
]